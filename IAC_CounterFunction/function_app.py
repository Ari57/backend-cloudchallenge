import azure.functions as func
import pymongo
import os

app = func.FunctionApp(http_auth_level=func.AuthLevel.ANONYMOUS)

@app.route(route="http_trigger")
def http_trigger(req: func.HttpRequest) -> func.HttpResponse:

    CONNECTION_STRING = os.environ.get("MONGODB_URI")
    client = pymongo.MongoClient(CONNECTION_STRING)

    database = client["iac-db"]
    counter = database["website-counter"]

    filter = {"id": "counter"}
    updateDocument = {
        "$inc": {
            "count" : 1
        }
    }
    
    resetDocument = {
        "$set": {
            "count" : 0
        }
    }

    counter.update_one(filter, updateDocument)
    query = {"id": "counter"}
    count = counter.find_one(query)
    result = str(count["count"])
    client.close()
    return func.HttpResponse(result, status_code=200)