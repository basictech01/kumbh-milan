class Profile:
    def __init__(
        self,
        user_id,
        name,
        age,
        gender,
        home_town,
        language,
        occupation,
        education,
        sub_group,
        about,
        interests,
        looking_for,
        advice_to_younger_self,
        your_meaning_of_life,
        biggest_achievement,
        biggest_challenge,
        profile_picture_url,
        phone=None,
    ):
        self.user_id = user_id
        self.name = name
        self.age = age
        self.gender = gender
        self.home_town = home_town
        self.language = language
        self.occupation = occupation
        self.education = education
        self.sub_group = sub_group
        self.about = about
        self.interests = interests
        self.looking_for = looking_for
        self.advice_to_younger_self = advice_to_younger_self
        self.your_meaning_of_life = your_meaning_of_life
        self.biggest_achievement = biggest_achievement
        self.biggest_challenge = biggest_challenge
        self.profile_picture_url = profile_picture_url
        self.phone = phone

    def empty_profile(user_id):
        return Profile(
            user_id=user_id,
            name=None,
            age=None,
            gender=None,
            home_town=None,
            language=None,
            occupation=None,
            education=None,
            sub_group=None,
            about=None,
            interests=None,
            looking_for=None,
            advice_to_younger_self=None,
            your_meaning_of_life=None,
            biggest_achievement=None,
            biggest_challenge=None,
            profile_picture_url=None,
            phone=None,
        )

    def to_dict(self):
        return {
            "user_id": self.user_id,
            "age": self.age,
            "name": self.name,
            "gender": self.gender,
            "home_town": self.home_town,
            "language": self.language,
            "occupation": self.occupation,
            "education": self.education,
            "sub_group": self.sub_group,
            "about": self.about,
            "interests": self.interests,
            "looking_for": self.looking_for,
            "advice_to_younger_self": self.advice_to_younger_self,
            "your_meaning_of_life": self.your_meaning_of_life,
            "biggest_achievement": self.biggest_achievement,
            "biggest_challenge": self.biggest_challenge,
            "profile_picture_url": self.profile_picture_url,
            "phone": self.phone,
        }
