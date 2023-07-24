# the inclusion of the tests module is not meant to offer best practices for
# testing in general, but rather to support the `find_packages` example in
# setup.py that excludes installing the "tests" package

from doctest import testmod
from unittest import TestCase, main
from sample import simple

from sample.simple import add_one


class TestSimple(TestCase):

    def test_add_one(self):
        self.assertEqual(add_one(5), 6)

    def test_examples(self):
        """This test wont work properly until the package has been installed
        into the virtual environment."""
        testResults = testmod(simple)
        self.assertNotEqual(testResults.attempted, 0)
        self.assertEqual(testResults.failed, 0)



if __name__ == '__main__':
    main()
