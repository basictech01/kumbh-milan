class ProfileModel {
  int? age;
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
    this.age,
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
      "interests": interests,
      "language": languages,
      "profile_picture_url": profilePictureUrl,
    };
  }
}
