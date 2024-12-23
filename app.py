from flask import Flask, render_template
import os
import random

app = Flask(__name__)

# list of cat images
images = [
    "https://th.bing.com/th/id/R.69bc0dd23ecbc52186c9f8226db663f6?rik=%2fkEH7eUmt7QsUQ&pid=ImgRaw&r=0",
]


@app.route("/")
def index():
    url = random.choice(images)
    return render_template("index.html", url=url)


if __name__ == "__main__":
    app.run(host="0.0.0.0", port=int(os.environ.get("PORT", 5000)))
