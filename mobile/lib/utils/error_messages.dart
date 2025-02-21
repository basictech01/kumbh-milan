import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ErrorMessages {
  // General Errors
  static String unknownError(BuildContext context) =>
      AppLocalizations.of(context)!.unknownError;

  // Login Errors
  static String loginFailed(BuildContext context) =>
      AppLocalizations.of(context)!.loginFailed;
  static String invalidPassword(BuildContext context) =>
      AppLocalizations.of(context)!.invalidPassword;
  static String userNotFound(BuildContext context) =>
      AppLocalizations.of(context)!.userNotFound;
  static String incorrectPassword(BuildContext context) =>
      AppLocalizations.of(context)!.incorrectPassword;
  static String serverError(BuildContext context) =>
      AppLocalizations.of(context)!.serverError;

  // Signup Errors
  static String signupFailed(BuildContext context) =>
      AppLocalizations.of(context)!.signupFailed;
  static String userNameAlreadyExists(BuildContext context) =>
      AppLocalizations.of(context)!.userAlreadyExists;
  static String weakPassword(BuildContext context) =>
      AppLocalizations.of(context)!.weakPassword;
  static String unknownSignupError(BuildContext context) =>
      AppLocalizations.of(context)!.unknownError;

  // Network Errors
  static String networkError(BuildContext context) =>
      AppLocalizations.of(context)!.networkError;
}
