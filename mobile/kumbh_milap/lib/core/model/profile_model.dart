class ProfileModel {
  final String name;
  final int age;
  final String gender;
  final String? about;
  String? profilePictureUrl;
  final String? home;
  final String? occupation;
  final String? education;
  final String? subgroup;
  final String? lookingFor;
  final String? advice;
  final String? meaningOfLife;
  final String? achievements;
  final String? challenges;
  final List<String>? interests;
  final List<String>? languages;

  ProfileModel({
    required this.name,
    required this.age,
    required this.gender,
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
      "name": name,
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
      "interests": interests,
      "language": languages,
      "profile_picture_url": profilePictureUrl,
    };
  }

  // Factory constructor to create an instance from JSON
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      name: json['name'],
      age: json['age'],
      gender: json['gender'],
      about: json['about'],
      profilePictureUrl: json['profile_picture_url'],
      home: json['home_town'],
      occupation: json['occupation'],
      education: json['education'],
      subgroup: json['sub_group'],
      lookingFor: json['looking_for'],
      advice: json['advice_to_younger_self'],
      meaningOfLife: json['your_meaning_of_life'],
      achievements: json['biggest_achievement'],
      challenges: json['biggest_challenge'],
      interests: List<String>.from(json['interests']),
      languages: List<String>.from(json['language']),
    );
  }
}
