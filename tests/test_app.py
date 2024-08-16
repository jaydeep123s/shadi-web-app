# tests/test_app.py
import unittest
from app.app import app

class AppTestCase(unittest.TestCase):
    def setUp(self):
        self.app = app.test_client()
        self.app.testing = True

    def test_home(self):
        response = self.app.get('/')
        self.assertEqual(response.status_code, 200)
        self.assertEqual(response.data, b"Welcome to Shadi.com")

if __name__ == '__main__':
    unittest.main()

