import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appName => 'कुंभ मिलन';

  @override
  String get langauge => 'हिंदी';

  @override
  String get login => 'लॉग इन';

  @override
  String get phone => 'फ़ोन नंबर';

  @override
  String get signUp => 'साइन अप';

  @override
  String get emailLabel => 'ईमेल';

  @override
  String get passwordLabel => 'पासवर्ड';

  @override
  String get usernameLabel => 'उपयोगकर्ता नाम';

  @override
  String get confirmPasswordLabel => 'पासवर्ड की पुष्टि करें';

  @override
  String get noAccountText => 'खाता नहीं है? साइन अप करें';

  @override
  String get haveAccountText => 'पहले से ही खाता है? लॉग इन करें';

  @override
  String get emailRequiredError => 'कृपया अपना ईमेल दर्ज करें';

  @override
  String get invalidEmailError => 'कृपया एक वैध ईमेल दर्ज करें';

  @override
  String get passwordRequiredError => 'कृपया अपना पासवर्ड दर्ज करें';

  @override
  String get passwordLengthError => 'पासवर्ड कम से कम 6 अक्षर लंबा होना चाहिए';

  @override
  String get usernameRequiredError => 'कृपया एक उपयोगकर्ता नाम दर्ज करें';

  @override
  String get usernameLengthError => 'उपयोगकर्ता नाम कम से कम 3 अक्षर लंबा होना चाहिए';

  @override
  String get passwordMatchError => 'पासवर्ड मेल नहीं खाते';

  @override
  String get fullname => 'नाम';

  @override
  String get age => 'आयु';

  @override
  String get gender => 'लिंग';

  @override
  String get genderMale => 'पुरुष';

  @override
  String get genderFemale => 'महिला';

  @override
  String get genderOther => 'अन्य';

  @override
  String get home => 'होम';

  @override
  String get location => 'स्थान';

  @override
  String get prefLanguage => 'पसंदीदा भाषा';

  @override
  String get subGroup => 'जाति';

  @override
  String get bio => 'आपके बारे में';

  @override
  String get education => 'शिक्षा';

  @override
  String get occupation => 'काम';

  @override
  String get lookingFor => 'आप क्या ढूंढ रहे हैं?';

  @override
  String get interests => 'रुचियाँ';

  @override
  String get advice => 'अपने युवा आत्मा को सलाह| ';

  @override
  String get meaningOfLife => 'जीवन का अर्थ';

  @override
  String get achievements => 'आपकी सबसे बड़ी प्राप्तियाँ| ';

  @override
  String get challenges => 'आपने किस सबसे बड़ी चुनौतियों का सामना किया है?';

  @override
  String get profileNotFound => 'प्रोफ़ाइल नहीं मिली';

  @override
  String get unknownError => 'अज्ञात त्रुटि';

  @override
  String get logout => 'लॉग आउट';

  @override
  String get personalInfo => 'व्यक्तिगत जानकारी';

  @override
  String get additionInfo => 'अतिरिक्त जानकारी';

  @override
  String get error => 'त्रुटि';

  @override
  String get ok => 'ठीक है';

  @override
  String welcomeUser(String username) {
    return '$username';
  }

  @override
  String get swipeLeft => 'बाएं स्वाइप करें';

  @override
  String get swipeRight => 'दाएं स्वाइप करें';

  @override
  String get match => 'मिलान';

  @override
  String get loginFailed => 'लॉगिन विफल। कृपया अपनी साख की जाँच करें और पुनः प्रयास करें।';

  @override
  String get submit => 'प्रोफ़ाइल बनाएं';

  @override
  String get invalidPassword => 'अमान्य पासवर्ड।';

  @override
  String get userNotFound => 'उपयोगकर्ता नहीं मिला।';

  @override
  String get userAlreadyExists => 'उपयोगकर्ता पहले से मौजूद है।';

  @override
  String get serverError => 'सर्वर त्रुटि। कृपया अपना इंटरनेट कनेक्शन जांचें और पुनः प्रयास करें।';

  @override
  String get incorrectPassword => 'गलत पासवर्ड।';

  @override
  String get signupFailed => 'साइनअप विफल। कृपया अपनी जानकारी की जाँच करें और पुनः प्रयास करें।';

  @override
  String get emailAlreadyInUse => 'यह ईमेल पता पहले से ही उपयोग में है।';

  @override
  String get weakPassword => 'पासवर्ड बहुत कमजोर है।';

  @override
  String get profileSuccess => 'प्रोफ़ाइल सफलतापूर्वक बनाई गई।';

  @override
  String get invalidUsername => 'अमान्य उपयोगकर्ता नाम।';

  @override
  String get likes => 'पसंद';

  @override
  String get noLikesFound => 'अभी तक कोई लाइक नहीं';

  @override
  String get noMatchesFound => 'अभी तक कोई मैच नहीं मिला';

  @override
  String get doMatch => 'अब मिलान करें';

  @override
  String get noProfilesFound => 'कोई प्रोफ़ाइल नहीं मिली';

  @override
  String get pullToRefresh => 'रिफ्रेश करने के लिए नीचे खींचें';

  @override
  String get editProfile => 'प्रोफ़ाइल संपादित करें';

  @override
  String get callNow => 'अभी कॉल करें';

  @override
  String get next => 'आगे बढ़ें';

  @override
  String get termsAndConditions => 'नियम और शर्तें';

  @override
  String get networkError => 'नेटवर्क त्रुटि। कृपया अपना इंटरनेट कनेक्शन जांचें और पुनः प्रयास करें।';

  @override
  String get noUsersFound => 'कोई उपयोगकर्ता नहीं मिला।';
}
