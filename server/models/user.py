class User:
    def __init__(self, id, name, phone, access_token, refresh_token):
        self.id = id
        self.name = name
        self.phone = phone
        self.access_token = access_token
        self.refresh_token = refresh_token

    def to_dict(self):
        return {
            "id": self.id,
            "name": self.name,
            "phone": self.phone,
            "access_token": self.access_token,
            "refresh_token": self.refresh_token,
        }
