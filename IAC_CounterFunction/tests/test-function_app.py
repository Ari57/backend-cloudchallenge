import unittest
import sys
import os
import requests

sys.path.append(os.path.dirname(os.path.realpath(__file__)) + "/../../IAC_CounterFunction")
from config import GetDatabase

client = GetDatabase()

database = client["iac-db"]
counter = database["website-counter"]

def GetCount():
    query = {"id": "counter"}
    count = counter.find_one(query)
    result = count["count"]
    return result

class TestInput(unittest.TestCase):
    def test_HttpResponse(self):
        response = requests.get("https://iac-countertrigger.azurewebsites.net/api/http_trigger")
        self.assertEqual(response.status_code, 200)
    
    def test_CorrectValue(self):
        OldCount = GetCount()
        requests.get("https://iac-countertrigger.azurewebsites.net/api/http_trigger")
        NewCount = GetCount()

        self.assertEqual(NewCount-1, OldCount)    

if __name__ == "__main__":
    unittest.main()
    client.close()
