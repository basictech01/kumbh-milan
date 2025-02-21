import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Kumbh Milap';

  @override
  String get langauge => 'English';

  @override
  String get login => 'Login';

  @override
  String get phone => 'Phone Number';

  @override
  String get signUp => 'Sign Up';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get usernameLabel => 'Username';

  @override
  String get confirmPasswordLabel => 'Confirm Password';

  @override
  String get noAccountText => 'Don\'t have an account? Sign Up';

  @override
  String get haveAccountText => 'Already have an account? Login';

  @override
  String get emailRequiredError => 'Please enter your email';

  @override
  String get invalidEmailError => 'Please enter a valid email';

  @override
  String get passwordRequiredError => 'Please enter your password';

  @override
  String get passwordLengthError => 'Password must be at least 6 characters long';

  @override
  String get usernameRequiredError => 'Please enter a username';

  @override
  String get usernameLengthError => 'Username must be at least 3 characters long';

  @override
  String get passwordMatchError => 'Passwords do not match.';

  @override
  String get fullname => 'Full Name';

  @override
  String get age => 'Age';

  @override
  String get gender => 'Gender';

  @override
  String get genderMale => 'MALE';

  @override
  String get genderFemale => 'FEMALE';

  @override
  String get genderOther => 'OTHER';

  @override
  String get home => 'Home';

  @override
  String get location => 'Location';

  @override
  String get prefLanguage => 'Preferred Language';

  @override
  String get subGroup => 'Sub Group';

  @override
  String get bio => 'Bio';

  @override
  String get education => 'Education';

  @override
  String get occupation => 'Occupation';

  @override
  String get lookingFor => 'Looking For? ';

  @override
  String get interests => 'Interests';

  @override
  String get advice => 'Advice to your younger self: ';

  @override
  String get meaningOfLife => 'Meaning of Life?';

  @override
  String get achievements => 'Your Biggest Achievements: ';

  @override
  String get challenges => 'Biggest Challenges you faced?';

  @override
  String get profileNotFound => 'Profile not found';

  @override
  String get unknownError => 'An unknown error occurred';

  @override
  String get logout => 'Logout';

  @override
  String get personalInfo => 'Personal Information';

  @override
  String get additionInfo => 'Additional Information';

  @override
  String get error => 'Error';

  @override
  String get ok => 'OK';

  @override
  String welcomeUser(String username) {
    return '$username';
  }

  @override
  String get swipeLeft => 'Swipe Left';

  @override
  String get swipeRight => 'Swipe Right';

  @override
  String get match => 'Matches';

  @override
  String get loginFailed => 'Login failed. Please check your credentials and try again.';

  @override
  String get submit => 'Submit';

  @override
  String get invalidPassword => 'Invalid password.';

  @override
  String get userNotFound => 'User not found.';

  @override
  String get userAlreadyExists => 'User already exists.';

  @override
  String get serverError => 'Server error. Please try again later.';

  @override
  String get incorrectPassword => 'Incorrect password.';

  @override
  String get signupFailed => 'Signup failed. Please check your details and try again.';

  @override
  String get emailAlreadyInUse => 'This email address is already in use.';

  @override
  String get weakPassword => 'The password is too weak.';

  @override
  String get profileSuccess => 'Profile created successfully.';

  @override
  String get invalidUsername => 'Invalid username.';

  @override
  String get likes => 'Likes';

  @override
  String get noLikesFound => 'No likes yet';

  @override
  String get noMatchesFound => 'No matches found yet';

  @override
  String get doMatch => 'Match Now';

  @override
  String get noProfilesFound => 'No profiles found';

  @override
  String get pullToRefresh => 'Pull down to refresh';

  @override
  String get editProfile => 'Edit Profile';

  @override
  String get callNow => 'Call Now';

  @override
  String get next => 'Next';

  @override
  String get termsAndConditions => 'Terms and Conditions';

  @override
  String get networkError => 'Network error. Please check your internet connection and try again.';

  @override
  String get noUsersFound => 'No users found.';
}
