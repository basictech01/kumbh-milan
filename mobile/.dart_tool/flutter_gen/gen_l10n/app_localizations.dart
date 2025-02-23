import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_hi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'gen_l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('hi')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Kumbh Milan**
  String get appName;

  /// Current Langauge
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get langauge;

  /// Text for the login
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// Label for the phone number field
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phone;

  /// Text for the sign up
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// Label for the email field
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get emailLabel;

  /// Label for the password field
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get passwordLabel;

  /// Label for the username field
  ///
  /// In en, this message translates to:
  /// **'Username'**
  String get usernameLabel;

  /// Label for the confirm password field
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPasswordLabel;

  /// Text for the no account prompt
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account? Sign Up'**
  String get noAccountText;

  /// Text for the have account prompt
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Login'**
  String get haveAccountText;

  /// Error message for missing email
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get emailRequiredError;

  /// Error message for invalid email
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmailError;

  /// Error message for missing password
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get passwordRequiredError;

  /// Error message for short password
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters long'**
  String get passwordLengthError;

  /// Error message for missing username
  ///
  /// In en, this message translates to:
  /// **'Please enter a username'**
  String get usernameRequiredError;

  /// Error message for short username
  ///
  /// In en, this message translates to:
  /// **'Username must be at least 3 characters long'**
  String get usernameLengthError;

  /// Error message for password mismatch
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match.'**
  String get passwordMatchError;

  /// Label for the full name field
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullname;

  /// Label for the age field
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get age;

  /// Label for the Gender field
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// Label for male gender
  ///
  /// In en, this message translates to:
  /// **'MALE'**
  String get genderMale;

  /// Label for female gender
  ///
  /// In en, this message translates to:
  /// **'FEMALE'**
  String get genderFemale;

  /// Label for other genders
  ///
  /// In en, this message translates to:
  /// **'OTHER'**
  String get genderOther;

  /// Text for the home
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// Label for the location field
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// Label for the preferred language field
  ///
  /// In en, this message translates to:
  /// **'Preferred Language'**
  String get prefLanguage;

  /// Label for the sub group field
  ///
  /// In en, this message translates to:
  /// **'Sub Group'**
  String get subGroup;

  /// Label for the bio field
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get bio;

  /// Label for the education field
  ///
  /// In en, this message translates to:
  /// **'Education'**
  String get education;

  /// Label for the occupation field
  ///
  /// In en, this message translates to:
  /// **'Occupation'**
  String get occupation;

  /// Label for the looking for field
  ///
  /// In en, this message translates to:
  /// **'Looking For? '**
  String get lookingFor;

  /// Label for the interests field
  ///
  /// In en, this message translates to:
  /// **'Interests'**
  String get interests;

  /// Label for the advice field
  ///
  /// In en, this message translates to:
  /// **'Advice to your younger self: '**
  String get advice;

  /// Label for the meaning of life field
  ///
  /// In en, this message translates to:
  /// **'Meaning of Life?'**
  String get meaningOfLife;

  /// Label for the achievements field
  ///
  /// In en, this message translates to:
  /// **'Your Biggest Achievements: '**
  String get achievements;

  /// Label for the challenges field
  ///
  /// In en, this message translates to:
  /// **'Biggest Challenges you faced?'**
  String get challenges;

  /// Error message for profile not found
  ///
  /// In en, this message translates to:
  /// **'Profile not found'**
  String get profileNotFound;

  /// Error message for unknown error
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred'**
  String get unknownError;

  /// Text for the logout
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// Label for the personal information section
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInfo;

  /// Label for the additional information section
  ///
  /// In en, this message translates to:
  /// **'Additional Information'**
  String get additionInfo;

  /// Title for the error dialog
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// Text for the OK button
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// Welcome message for the user
  ///
  /// In en, this message translates to:
  /// **'{username}'**
  String welcomeUser(String username);

  /// Text for the swipe left
  ///
  /// In en, this message translates to:
  /// **'Swipe Left'**
  String get swipeLeft;

  /// Text for the swipe right
  ///
  /// In en, this message translates to:
  /// **'Swipe Right'**
  String get swipeRight;

  /// Text for the match
  ///
  /// In en, this message translates to:
  /// **'Matches'**
  String get match;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed. Please check your credentials and try again.'**
  String get loginFailed;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @invalidPassword.
  ///
  /// In en, this message translates to:
  /// **'Invalid password.'**
  String get invalidPassword;

  /// No description provided for @userNotFound.
  ///
  /// In en, this message translates to:
  /// **'User not found.'**
  String get userNotFound;

  /// No description provided for @userAlreadyExists.
  ///
  /// In en, this message translates to:
  /// **'User already exists.'**
  String get userAlreadyExists;

  /// No description provided for @serverError.
  ///
  /// In en, this message translates to:
  /// **'Server error. Please try again later.'**
  String get serverError;

  /// No description provided for @incorrectPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get incorrectPassword;

  /// No description provided for @signupFailed.
  ///
  /// In en, this message translates to:
  /// **'Signup failed. Please check your details and try again.'**
  String get signupFailed;

  /// No description provided for @emailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'This email address is already in use.'**
  String get emailAlreadyInUse;

  /// No description provided for @weakPassword.
  ///
  /// In en, this message translates to:
  /// **'The password is too weak.'**
  String get weakPassword;

  /// No description provided for @profileSuccess.
  ///
  /// In en, this message translates to:
  /// **'Profile created successfully.'**
  String get profileSuccess;

  /// No description provided for @invalidUsername.
  ///
  /// In en, this message translates to:
  /// **'Invalid username.'**
  String get invalidUsername;

  /// No description provided for @likes.
  ///
  /// In en, this message translates to:
  /// **'Likes'**
  String get likes;

  /// No description provided for @noLikesFound.
  ///
  /// In en, this message translates to:
  /// **'No likes yet'**
  String get noLikesFound;

  /// No description provided for @noMatchesFound.
  ///
  /// In en, this message translates to:
  /// **'No matches found yet'**
  String get noMatchesFound;

  /// No description provided for @doMatch.
  ///
  /// In en, this message translates to:
  /// **'Match Now'**
  String get doMatch;

  /// No description provided for @noProfilesFound.
  ///
  /// In en, this message translates to:
  /// **'No profiles found'**
  String get noProfilesFound;

  /// No description provided for @pullToRefresh.
  ///
  /// In en, this message translates to:
  /// **'Pull down to refresh'**
  String get pullToRefresh;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @callNow.
  ///
  /// In en, this message translates to:
  /// **'Call Now'**
  String get callNow;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms and Conditions'**
  String get termsAndConditions;

  /// No description provided for @networkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your internet connection and try again.'**
  String get networkError;

  /// No description provided for @noUsersFound.
  ///
  /// In en, this message translates to:
  /// **'No users found.'**
  String get noUsersFound;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'hi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'hi': return AppLocalizationsHi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
