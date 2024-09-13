import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get backButton => '返回';

  @override
  String get alertTitle => '警告！';

  @override
  String get alertYesBtn => '是';

  @override
  String get alertNoBtn => '否';

  @override
  String get alertOkBtn => '確定';

  @override
  String get alertCancelBtn => '取消';

  @override
  String get alertInstallBtn => '安裝';

  @override
  String get alertFillAllData => '請填寫所有資料。';
}

/// The translations for Chinese, as used in Taiwan (`zh_TW`).
class AppLocalizationsZhTw extends AppLocalizationsZh {
  AppLocalizationsZhTw(): super('zh_TW');

  @override
  String get backButton => '返回';

  @override
  String get alertTitle => '警告！';

  @override
  String get alertYesBtn => '是';

  @override
  String get alertNoBtn => '否';

  @override
  String get alertOkBtn => '確定';

  @override
  String get alertCancelBtn => '取消';

  @override
  String get alertInstallBtn => '安裝';

  @override
  String get alertFillAllData => '請填寫所有資料。';
}
