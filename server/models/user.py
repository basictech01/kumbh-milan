class User:
    def __init__(self, name, username, phone, access_token, refresh_token):
        self.name = name
        self.username = username
        self.phone = phone
        self.access_token = access_token
        self.refresh_token = refresh_token

    def to_dict(self):
        return {
            "name": self.name,
            "username": self.username,
            "phone": self.phone,
            "access_token": self.access_token,
            "refresh_token": self.refresh_token,
        }
