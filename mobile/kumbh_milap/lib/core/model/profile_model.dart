class ProfileModel {
  int? user_id;
  int? age;
  String? name;
  String? gender;
  String? about;
  String? profilePictureUrl;
  String? home;
  String? occupation;
  String? education;
  String? subgroup;
  String? lookingFor;
  String? advice;
  String? meaningOfLife;
  String? achievements;
  String? challenges;
  List<String>? interests;
  List<String>? languages;

  ProfileModel({
    this.user_id,
    this.age,
    this.name,
    this.gender,
    this.about,
    this.profilePictureUrl,
    this.home,
    this.occupation,
    this.education,
    this.subgroup,
    this.lookingFor,
    this.advice,
    this.meaningOfLife,
    this.achievements,
    this.challenges,
    this.interests,
    this.languages,
  });

  // Convert model to JSON for API requests
  Map<String, dynamic> toJson() {
    return {
      "age": age,
      "gender": gender,
      "about": about,
      "home_town": home,
      "occupation": occupation,
      "education": education,
      "sub_group": subgroup,
      "looking_for": lookingFor,
      "advice_to_younger_self": advice,
      "your_meaning_of_life": meaningOfLife,
      "biggest_achievement": achievements,
      "biggest_challenge": challenges,
      "interests": interests?.join(","),
      "language": languages?.join(","),
      "profile_picture_url": profilePictureUrl,
    };
  }

  // Convert JSON to model
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      user_id: json['user_id'],
      age: json['age'],
      name: json['name'],
      gender: json['gender'],
      about: json['about'],
      profilePictureUrl: json['profile_picture_url'],
      home: json['home_town'],
      occupation: json['occupation'],
      education: json['education'],
      subgroup: json['subgroup'],
      lookingFor: json['looking_for'],
      advice: json['advice_to_younger_self'],
      meaningOfLife: json['your_meaning_of_life'],
      achievements: json['biggest_achievement'],
      challenges: json['biggest_challenge'],
      interests: json['interests']?.split(","),
      languages: json['language']?.split(","),
    );
  }
}
