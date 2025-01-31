from flask import Flask, render_template, request
import socket
from datetime import datetime
import os

app = Flask(__name__)


@app.route("/")
def home():
    the_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    return render_template(
        "index.html",
        name="Maël Hostettler",
        project_name="El projecto",
        version="V1337",
        hostname=socket.gethostbyname(socket.gethostname()),
        current_date=the_date,
        history=["We", "Have", "No", "DB", "..."]
    )

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
