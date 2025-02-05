from flask import Flask

from routes.user import user
from utils.extensions import bcrypt, jwt
from utils.logging import setup_logging

app = Flask(__name__)
app.register_blueprint(user, url_prefix="/user")
app.config["JWT_SECRET_KEY"] = "supersecretkey"
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = 86400
app.config['JWT_REFRESH_TOKEN_EXPIRES'] = 365 * 24 * 60 * 60

bcrypt = bcrypt.init_app(app)
jwt.init_app(app)

@app.route("/")
def index():
    return "Hello World!"


if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=3001)
