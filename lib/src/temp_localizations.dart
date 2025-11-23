// 临时本地化 - 仅用于让应用在 macOS 上运行
// Temporary localizations to get the app running on macOS

import 'package:flutter/material.dart';

class AppLocalizations {
  final String localeName;

  AppLocalizations(this.localeName);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static List<LocalizationsDelegate<dynamic>> get localizationsDelegates => [
        delegate,
        // GlobalMaterialLocalizations.delegate,
        // GlobalWidgetsLocalizations.delegate,
        // GlobalCupertinoLocalizations.delegate,
      ];

  static List<Locale> get supportedLocales => [
        const Locale('en'),
        const Locale('ja'),
        const Locale('uk'),
      ];

  // App strings
  String get appTitle => 'Orgro';
  
  // Menu items
  String get menuItemAppearance => 'Appearance…';
  String get menuItemClearCache => 'Clear cache';
  String get menuItemOrgroManual => 'Orgro Manual';
  String get menuItemAbout => 'About';
  String get menuItemReaderMode => 'Reader mode';
  String get menuItemFullWidth => 'Full width';
  String get menuItemScrollTop => 'Scroll to top';
  String get menuItemScrollBottom => 'Scroll to bottom';
  
  // Appearance modes
  String get appearanceModeAutomatic => 'Automatic';
  String get appearanceModeLight => 'Light';
  String get appearanceModeDark => 'Dark';
  
  // Snackbar messages
  String get snackbarMessageCacheCleared => 'Cache cleared';
  String get snackbarMessageNeedsDirectoryPermissions =>
      'Orgro doesn\'t have permission to resolve relative links';
  String get snackbarActionGrantAccess => 'Grant access';
  
  // Dialog titles
  String get dialogTitleError => 'Error';
  
  // Page titles
  String get pageTitleError => 'Error';
  String get pageTitleLoading => 'Loading...';
  String pageTitleNarrow(String name) => '$name › narrow';
  
  // Buttons
  String get buttonOpenFile => 'Open File';
  String get buttonOpenOrgroManual => 'Open Orgro Manual';
  String get buttonOpenOrgManual => 'Open Org Manual';
  String get buttonSupport => 'Support · Feedback';
  String buttonVersion(String version) => 'v$version';
  
  // Section headers
  String get sectionHeaderRecentFiles => 'Recent files';
  
  // Search
  String get hintTextSearch => 'Search...';
  
  // About
  String get aboutLinkSupport => 'Support · Feedback';
  String get aboutLinkChangelog => 'Changelog';
  
  // Banners
  String get bannerBodyRemoteImages => 'This document contains remote images';
  String get bannerBodyActionShowAlways => 'Always show';
  String get bannerBodyActionShowNever => 'Never show';
  String get bannerBodyActionShowOnce => 'Show once';
  String get bannerBodyRelativeLinks => 'This document contains relative links';
  String get bannerBodyActionGrantNotNow => 'Not now';
  String get bannerBodyActionGrantNever => 'Never';
  String get bannerBodyActionGrantNow => 'Grant access';
  
  // Errors
  String errorUnknownType(Type type) => 'Unknown type: $type';
  String get errorCannotResolveRelativePath =>
      'Cannot resolve relative path';
  String errorUnexpectedHttpResponse(dynamic response) =>
      'Unexpected HTTP response: $response';
  String errorPathResolvedToNonFile(String path, String uri) =>
      '$path resolved to a non-file: $uri';
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ja', 'uk'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale.languageCode);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

