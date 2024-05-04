#!/usr/bin/env python3
import unittest
import sys

version: tuple[int, ...] = (3, 2)
class TestStringMethods(unittest.TestCase):
    __version__ = (1, 2)

    @unittest.skip("demonstrating skipping")
    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')

    @unittest.skipIf(version >= (1, 3), "not supported")
    def test_isupper(self):
        self.assertTrue('FOO'.isupper())
        self.assertFalse('Foo'.isupper())

    @unittest.skipUnless(sys.platform.startswith("win"), "requires Windows")
    def test_split(self):
        s = 'hello world'
        self.assertEqual(s.split(), ['hello', 'world'])
        with self.assertRaises(ZeroDivisionError):
            x = 3 / 0

if __name__ == '__main__':
    unittest.main()



