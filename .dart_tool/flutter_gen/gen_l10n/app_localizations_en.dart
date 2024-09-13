import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get backButton => 'Back';

  @override
  String get alertTitle => 'Warning!';

  @override
  String get alertYesBtn => 'Yes';

  @override
  String get alertNoBtn => 'No';

  @override
  String get alertOkBtn => 'OK';

  @override
  String get alertCancelBtn => 'Cancel';

  @override
  String get alertInstallBtn => 'Install';

  @override
  String get alertFillAllData => 'Please complete all fields.';
}
