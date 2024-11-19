import os
import platform
import re
import statistics
import subprocess
import sys
import tarfile
import tempfile
import unittest

from scripts.test import shared
from . import utils


def get_build_dir():
    # wasm-opt is in the bin/ dir, and the build dir is one above it,
    # and contains bin/ and lib/.
    return os.path.dirname(os.path.dirname(shared.WASM_OPT[0]))


# Windows is not yet supported.
@unittest.skipIf(platform.system() == 'Windows', "showing class skipping")
class ClusterFuzz(utils.BinaryenTestCase):
    @classmethod
    def setUpClass(cls):
        # Bundle up our ClusterFuzz package, and unbundle it to a directory.
        # Keep the directory alive in a class var.
        cls.temp_dir = tempfile.TemporaryDirectory()
        cls.clusterfuzz_dir = cls.temp_dir.name

        bundle = os.environ.get('BINARYEN_CLUSTER_FUZZ_BUNDLE')
        if bundle:
            print(f'Using existing bundle: {bundle}')
        else:
            print('Making a new bundle')
            bundle = os.path.join(cls.clusterfuzz_dir, 'bundle.tgz')
            cmd = [shared.in_binaryen('scripts', 'bundle_clusterfuzz.py')]
            cmd.append(bundle)
            cmd.append(f'--build-dir={get_build_dir()}')
            shared.run_process(cmd)

        print('Unpacking bundle')
        tar = tarfile.open(bundle, "r:gz")
        tar.extractall(path=cls.clusterfuzz_dir)
        tar.close()

        print('Ready')

    # Test our bundler for ClusterFuzz.
    def test_bundle(self):
        # The bundle should contain certain files:
        # 1. run.py, the main entry point.
        self.assertTrue(os.path.exists(os.path.join(self.clusterfuzz_dir, 'run.py')))
        # 2. scripts/fuzz_shell.js, the js testcase shell
        self.assertTrue(os.path.exists(os.path.join(self.clusterfuzz_dir, 'scripts', 'fuzz_shell.js')))
        # 3. bin/wasm-opt, the wasm-opt binary in a static build
        wasm_opt = os.path.join(self.clusterfuzz_dir, 'bin', 'wasm-opt')
        self.assertTrue(os.path.exists(wasm_opt))

        # See that we can execute the bundled wasm-opt. It should be able to
        # print out its version.
        out = subprocess.check_output([wasm_opt, '--version'], text=True)
        self.assertIn('wasm-opt version ', out)

    # Generate N testcases, using run.py from a temp dir, and outputting to a
    # testcase dir.
    def generate_testcases(self, N, testcase_dir):
        proc = subprocess.run([sys.executable,
                               os.path.join(self.clusterfuzz_dir, 'run.py'),
                               f'--output_dir={testcase_dir}',
                               f'--no_of_files={N}'],
                              text=True,
                              stdout=subprocess.PIPE,
                              stderr=subprocess.PIPE)
        self.assertEqual(proc.returncode, 0)
        return proc

    # Test the bundled run.py script.
    def test_run_py(self):
        temp_dir = tempfile.TemporaryDirectory()

        N = 10
        proc = self.generate_testcases(N, temp_dir.name)

        # We should have logged the creation of N testcases.
        self.assertEqual(proc.stdout.count('Created testcase:'), N)

        # We should have actually created them.
        for i in range(0, N + 2):
            fuzz_file = os.path.join(temp_dir.name, f'fuzz-binaryen-{i}.js')
            flags_file = os.path.join(temp_dir.name, f'flags-binaryen-{i}.js')
            # We actually emit the range [1, N], so 0 or N+1 should not exist.
            if i >= 1 and i <= N:
                self.assertTrue(os.path.exists(fuzz_file))
                self.assertTrue(os.path.exists(flags_file))
            else:
                self.assertTrue(not os.path.exists(fuzz_file))
                self.assertTrue(not os.path.exists(flags_file))

    def test_fuzz_passes(self):
        # We should see interesting passes being run in run.py. This is *NOT* a
        # deterministic test, since the number of passes run is random (we just
        # let run.py run normally, to simulate the real environment), so flakes
        # are possible here. However, we do the check in a way that the
        # statistical likelihood of a flake is insignificant. Specifically, we
        # just check that we see a different number of passes run in two
        # different invocations, which is enough to prove that we are running
        # different passes each time. And the number of passes is on average
        # over 100 here (10 testcases, and each runs 0-20 passes or so).
        temp_dir = tempfile.TemporaryDirectory()
        N = 10

        # Try many times to see a different number, to make flakes even less
        # likely. In the worst case if there were two possible numbers of
        # passes run, with equal probability, then if we failed 100 iterations
        # every second, we could go for billions of billions of years without a
        # flake. (And, if there are only two numbers with *non*-equal
        # probability then something is very wrong, and we'd like to see
        # errors.)
        seen_num_passes = set()
        for i in range(100):
            os.environ['BINARYEN_PASS_DEBUG'] = '1'
            try:
                proc = self.generate_testcases(N, temp_dir.name)
            finally:
                del os.environ['BINARYEN_PASS_DEBUG']

            num_passes = proc.stderr.count('running pass')
            print(f'num passes: {num_passes}')
            seen_num_passes.add(num_passes)
            if len(seen_num_passes) > 1:
                return
        raise Exception(f'We always only saw {seen_num_passes} passes run')

    def test_file_contents(self):
        # As test_fuzz_passes, this is nondeterministic, but statistically it is
        # almost impossible to get a flake here.
        temp_dir = tempfile.TemporaryDirectory()
        N = 100
        self.generate_testcases(N, temp_dir.name)

        # To check for interesting wasm file contents, we'll note how many
        # struct.news appear (a signal that we are emitting WasmGC, and also a
        # non-trivial number of them), the sizes of the wasm files, and the
        # exports.
        seen_struct_news = []
        seen_sizes = []
        seen_exports = []

        # The number of struct.news appears in the metrics report like this:
        #
        # StructNew      : 18
        #
        struct_news_regex = re.compile(r'StructNew\s+:\s+(\d+)')

        # The number of exports appears in the metrics report like this:
        #
        # [exports]      : 1
        #
        exports_regex = re.compile(r'\[exports\]\s+:\s+(\d+)')

        for i in range(1, N + 1):
            fuzz_file = os.path.join(temp_dir.name, f'fuzz-binaryen-{i}.js')
            flags_file = os.path.join(temp_dir.name, f'flags-binaryen-{i}.js')

            # The flags file must contain --wasm-staging
            with open(flags_file) as f:
                self.assertEqual(f.read(), '--wasm-staging')

            # The fuzz files begin with
            #
            #   var binary = new Uint8Array([..binary data as numbers..]);
            #
            with open(fuzz_file) as f:
                first_line = f.readline().strip()
                start = 'var binary = new Uint8Array(['
                end = ']);'
                self.assertTrue(first_line.startswith(start))
                self.assertTrue(first_line.endswith(end))
                numbers = first_line[len(start):-len(end)]

            # Convert to binary, and see that it is a valid file.
            numbers_array = [int(x) for x in numbers.split(',')]
            binary_file = os.path.join(temp_dir.name, 'file.wasm')
            with open(binary_file, 'wb') as f:
                f.write(bytes(numbers_array))
            metrics = subprocess.check_output(
                shared.WASM_OPT + ['-all', '--metrics', binary_file, '-q'], text=True)

            # Update with what we see.
            struct_news = re.findall(struct_news_regex, metrics)
            if not struct_news:
                # No line is emitted when --metrics sees no struct.news.
                struct_news = ['0']
            # Metrics should contain one line for StructNews.
            self.assertEqual(len(struct_news), 1)
            seen_struct_news.append(int(struct_news[0]))

            seen_sizes.append(os.path.getsize(binary_file))

            exports = re.findall(exports_regex, metrics)
            # Metrics should contain one line for exports.
            self.assertEqual(len(exports), 1)
            seen_exports.append(int(exports[0]))

        print()

        # struct.news appear to be distributed as mean 15, stddev 24, median 10,
        # so over 100 samples we are incredibly likely to see an interesting
        # number at least once. It is also incredibly unlikely for the stdev to
        # be zero.
        print(f'mean struct.news:   {statistics.mean(seen_struct_news)}')
        print(f'stdev struct.news:  {statistics.stdev(seen_struct_news)}')
        print(f'median struct.news: {statistics.median(seen_struct_news)}')
        self.assertGreaterEqual(max(seen_struct_news), 10)
        self.assertGreater(statistics.stdev(seen_struct_news), 0)

        print()

        # sizes appear to be distributed as mean 2933, stddev 2011, median 2510.
        print(f'mean sizes:   {statistics.mean(seen_sizes)}')
        print(f'stdev sizes:  {statistics.stdev(seen_sizes)}')
        print(f'median sizes: {statistics.median(seen_sizes)}')
        self.assertGreaterEqual(max(seen_sizes), 1000)
        self.assertGreater(statistics.stdev(seen_sizes), 0)

        print()

        # exports appear to be distributed as mean 9, stddev 6, median 8.
        print(f'mean exports:   {statistics.mean(seen_exports)}')
        print(f'stdev exports:  {statistics.stdev(seen_exports)}')
        print(f'median exports: {statistics.median(seen_exports)}')
        self.assertGreaterEqual(max(seen_exports), 8)
        self.assertGreater(statistics.stdev(seen_exports), 0)

        print()

    # "zzz" in test name so that this runs last. If it runs first, it can be
    # confusing as it appears next to the logging of which bundle we use (see
    # setUpClass).
    def test_zzz_bundle_build_dir(self):
        cmd = [shared.in_binaryen('scripts', 'bundle_clusterfuzz.py')]
        cmd.append('bundle.tgz')
        # Test that we notice the --build-dir flag. Here we pass an invalid
        # value, so we should error.
        cmd.append('--build-dir=foo_bar')

        failed = False
        try:
            subprocess.check_call(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        except subprocess.CalledProcessError:
            # Expected error.
            failed = True
        self.assertTrue(failed)

        # Test with a valid --build-dir.
        cmd.pop()
        cmd.append(f'--build-dir={get_build_dir()}')
        subprocess.check_call(cmd)