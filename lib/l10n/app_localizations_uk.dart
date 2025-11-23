// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Ukrainian (`uk`).
class AppLocalizationsUk extends AppLocalizations {
  AppLocalizationsUk([String locale = 'uk']) : super(locale);

  @override
  String get appTitle => 'Orgro';

  @override
  String get menuItemAppearance => 'Вигляд…';

  @override
  String get menuItemClearCache => 'Очистити кеш';

  @override
  String get menuItemOrgroManual => 'Посібник Orgro';

  @override
  String get menuItemAbout => 'Про застосунок';

  @override
  String get appearanceModeAutomatic => 'Автоматичний';

  @override
  String get appearanceModeLight => 'Світлий';

  @override
  String get appearanceModeDark => 'Темний';

  @override
  String get snackbarMessageCacheCleared => 'Кеш очищено';

  @override
  String get aboutLinkSupport => 'Підтримка · Зворотній звʼязок';

  @override
  String get aboutLinkChangelog => 'Список змін';

  @override
  String get buttonOpenFile => 'Відкрити файл';

  @override
  String get buttonOpenOrgroManual => 'Відкрити Посібник Orgro';

  @override
  String get buttonOpenOrgManual => 'Відкрити Посібник Org';

  @override
  String get buttonSupport => 'Підтримка · Зворотній звʼязок';

  @override
  String buttonVersion(Object version) {
    return 'в$version';
  }

  @override
  String get sectionHeaderRecentFiles => 'Останні файли';

  @override
  String get menuItemReaderMode => 'Режим читання';

  @override
  String get menuItemFullWidth => 'Full width';

  @override
  String get menuItemScrollTop => 'Прокрутити вверх';

  @override
  String get menuItemScrollBottom => 'Прокрутити вниз';

  @override
  String get hintTextSearch => 'Шукати...';

  @override
  String get snackbarMessageNeedsDirectoryPermissions =>
      'Orgro немає прав для розвʼязання відносних посилань';

  @override
  String get snackbarActionGrantAccess => 'Надати дозвіл';

  @override
  String get dialogTitleError => 'Помилка';

  @override
  String get pageTitleError => 'Помилка';

  @override
  String get pageTitleLoading => 'Завантаження...';

  @override
  String pageTitleNarrow(Object name) {
    return '$name › гілка';
  }

  @override
  String get bannerBodyRemoteImages =>
      'Цей документ містить віддалені зображення. Бажаєте завантажувати їх?';

  @override
  String get bannerBodyActionShowAlways => 'Завжди';

  @override
  String get bannerBodyActionShowNever => 'Ніколи';

  @override
  String get bannerBodyActionShowOnce => 'Лише раз';

  @override
  String get bannerBodyRelativeLinks =>
      'Цей документ містить відносні посилання. Бажаєте надати дозвіл?';

  @override
  String get bannerBodyActionGrantNotNow => 'Не зараз';

  @override
  String get bannerBodyActionGrantNever => 'Ніколи';

  @override
  String get bannerBodyActionGrantNow => 'Надати дозвіл';

  @override
  String get errorCannotResolveRelativePath =>
      'Не можливо розвʼязати шлях відносно цього документа';

  @override
  String errorPathResolvedToNonFile(Object path, Object resolved) {
    return '$path визначено як не файл: $resolved';
  }

  @override
  String errorUnknownType(Object type) {
    return 'Невідомий тип: $type';
  }

  @override
  String errorUnexpectedHttpResponse(Object response) {
    return 'Неочікувана відповідь HTTP: $response';
  }
}
