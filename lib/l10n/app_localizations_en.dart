// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Orgro';

  @override
  String get menuItemAppearance => 'Appearance…';

  @override
  String get menuItemClearCache => 'Clear cache';

  @override
  String get menuItemOrgroManual => 'Orgro Manual';

  @override
  String get menuItemAbout => 'About';

  @override
  String get appearanceModeAutomatic => 'Automatic';

  @override
  String get appearanceModeLight => 'Light';

  @override
  String get appearanceModeDark => 'Dark';

  @override
  String get snackbarMessageCacheCleared => 'Cache cleared';

  @override
  String get aboutLinkSupport => 'Support · Feedback';

  @override
  String get aboutLinkChangelog => 'Changelog';

  @override
  String get buttonOpenFile => 'Open File';

  @override
  String get buttonOpenOrgroManual => 'Open Orgro Manual';

  @override
  String get buttonOpenOrgManual => 'Open Org Manual';

  @override
  String get buttonSupport => 'Support · Feedback';

  @override
  String buttonVersion(Object version) {
    return 'v$version';
  }

  @override
  String get sectionHeaderRecentFiles => 'Recent files';

  @override
  String get menuItemReaderMode => 'Reader mode';

  @override
  String get menuItemFullWidth => 'Full width';

  @override
  String get menuItemScrollTop => 'Scroll to top';

  @override
  String get menuItemScrollBottom => 'Scroll to bottom';

  @override
  String get hintTextSearch => 'Search...';

  @override
  String get snackbarMessageNeedsDirectoryPermissions =>
      'Orgro doesn’t have permission to resolve relative links';

  @override
  String get snackbarActionGrantAccess => 'Grant access';

  @override
  String get dialogTitleError => 'Error';

  @override
  String get pageTitleError => 'Error';

  @override
  String get pageTitleLoading => 'Loading...';

  @override
  String pageTitleNarrow(Object name) {
    return '$name › narrow';
  }

  @override
  String get bannerBodyRemoteImages =>
      'This document contains remote images. Would you like to load them?';

  @override
  String get bannerBodyActionShowAlways => 'Always';

  @override
  String get bannerBodyActionShowNever => 'Never';

  @override
  String get bannerBodyActionShowOnce => 'Just once';

  @override
  String get bannerBodyRelativeLinks =>
      'This document contains relative links. Would you like to grant access?';

  @override
  String get bannerBodyActionGrantNotNow => 'Not now';

  @override
  String get bannerBodyActionGrantNever => 'Never';

  @override
  String get bannerBodyActionGrantNow => 'Grant access';

  @override
  String get errorCannotResolveRelativePath =>
      'Can’t resolve path relative to this document';

  @override
  String errorPathResolvedToNonFile(Object path, Object resolved) {
    return '$path resolved to a non-file: $resolved';
  }

  @override
  String errorUnknownType(Object type) {
    return 'Unknown type: $type';
  }

  @override
  String errorUnexpectedHttpResponse(Object response) {
    return 'Unexpected HTTP response: $response';
  }
}
