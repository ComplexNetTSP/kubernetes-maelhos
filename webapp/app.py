from flask import Flask, render_template, request
import socket
from datetime import datetime
from pymongo import MongoClient
import os

app = Flask(__name__)

mongodb_host = os.getenv("MONGO_HOST", "localhost")
client = MongoClient(f"mongodb://{mongodb_host}:27017/")
db = client["connection_db"]  # Replace with your database name
collection = db["connection_collection"]  # Replace with your collection name


@app.route("/")
def home():
    the_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    record = {
        "req": "Client request :",
        "ip": request.remote_addr,
        "date": the_date
    }
    collection.insert_one(record)

    return render_template(
        "index.html",
        name="Maël Hostettler",
        project_name="El projecto",
        version="V1337",
        hostname=socket.gethostbyname(socket.gethostname()),
        current_date=the_date,
        history=[f'{doc["req"]} {doc["ip"]}, {doc["date"]}' for doc in collection.find().sort("date", -1).limit(10)]
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
