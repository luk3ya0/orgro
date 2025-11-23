import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_uk.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
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
  AppLocalizations(String locale)
      : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

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
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja'),
    Locale('uk')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'Orgro'**
  String get appTitle;

  /// No description provided for @menuItemAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance…'**
  String get menuItemAppearance;

  /// No description provided for @menuItemClearCache.
  ///
  /// In en, this message translates to:
  /// **'Clear cache'**
  String get menuItemClearCache;

  /// No description provided for @menuItemOrgroManual.
  ///
  /// In en, this message translates to:
  /// **'Orgro Manual'**
  String get menuItemOrgroManual;

  /// No description provided for @menuItemAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get menuItemAbout;

  /// No description provided for @appearanceModeAutomatic.
  ///
  /// In en, this message translates to:
  /// **'Automatic'**
  String get appearanceModeAutomatic;

  /// No description provided for @appearanceModeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get appearanceModeLight;

  /// No description provided for @appearanceModeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get appearanceModeDark;

  /// No description provided for @snackbarMessageCacheCleared.
  ///
  /// In en, this message translates to:
  /// **'Cache cleared'**
  String get snackbarMessageCacheCleared;

  /// No description provided for @aboutLinkSupport.
  ///
  /// In en, this message translates to:
  /// **'Support · Feedback'**
  String get aboutLinkSupport;

  /// No description provided for @aboutLinkChangelog.
  ///
  /// In en, this message translates to:
  /// **'Changelog'**
  String get aboutLinkChangelog;

  /// No description provided for @buttonOpenFile.
  ///
  /// In en, this message translates to:
  /// **'Open File'**
  String get buttonOpenFile;

  /// No description provided for @buttonOpenOrgroManual.
  ///
  /// In en, this message translates to:
  /// **'Open Orgro Manual'**
  String get buttonOpenOrgroManual;

  /// No description provided for @buttonOpenOrgManual.
  ///
  /// In en, this message translates to:
  /// **'Open Org Manual'**
  String get buttonOpenOrgManual;

  /// No description provided for @buttonSupport.
  ///
  /// In en, this message translates to:
  /// **'Support · Feedback'**
  String get buttonSupport;

  /// No description provided for @buttonVersion.
  ///
  /// In en, this message translates to:
  /// **'v{version}'**
  String buttonVersion(Object version);

  /// No description provided for @sectionHeaderRecentFiles.
  ///
  /// In en, this message translates to:
  /// **'Recent files'**
  String get sectionHeaderRecentFiles;

  /// No description provided for @menuItemReaderMode.
  ///
  /// In en, this message translates to:
  /// **'Reader mode'**
  String get menuItemReaderMode;

  /// No description provided for @menuItemFullWidth.
  ///
  /// In en, this message translates to:
  /// **'Full width'**
  String get menuItemFullWidth;

  /// No description provided for @menuItemScrollTop.
  ///
  /// In en, this message translates to:
  /// **'Scroll to top'**
  String get menuItemScrollTop;

  /// No description provided for @menuItemScrollBottom.
  ///
  /// In en, this message translates to:
  /// **'Scroll to bottom'**
  String get menuItemScrollBottom;

  /// No description provided for @hintTextSearch.
  ///
  /// In en, this message translates to:
  /// **'Search...'**
  String get hintTextSearch;

  /// No description provided for @snackbarMessageNeedsDirectoryPermissions.
  ///
  /// In en, this message translates to:
  /// **'Orgro doesn’t have permission to resolve relative links'**
  String get snackbarMessageNeedsDirectoryPermissions;

  /// No description provided for @snackbarActionGrantAccess.
  ///
  /// In en, this message translates to:
  /// **'Grant access'**
  String get snackbarActionGrantAccess;

  /// No description provided for @dialogTitleError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get dialogTitleError;

  /// No description provided for @pageTitleError.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get pageTitleError;

  /// No description provided for @pageTitleLoading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get pageTitleLoading;

  /// No description provided for @pageTitleNarrow.
  ///
  /// In en, this message translates to:
  /// **'{name} › narrow'**
  String pageTitleNarrow(Object name);

  /// No description provided for @bannerBodyRemoteImages.
  ///
  /// In en, this message translates to:
  /// **'This document contains remote images. Would you like to load them?'**
  String get bannerBodyRemoteImages;

  /// No description provided for @bannerBodyActionShowAlways.
  ///
  /// In en, this message translates to:
  /// **'Always'**
  String get bannerBodyActionShowAlways;

  /// No description provided for @bannerBodyActionShowNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get bannerBodyActionShowNever;

  /// No description provided for @bannerBodyActionShowOnce.
  ///
  /// In en, this message translates to:
  /// **'Just once'**
  String get bannerBodyActionShowOnce;

  /// No description provided for @bannerBodyRelativeLinks.
  ///
  /// In en, this message translates to:
  /// **'This document contains relative links. Would you like to grant access?'**
  String get bannerBodyRelativeLinks;

  /// No description provided for @bannerBodyActionGrantNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get bannerBodyActionGrantNotNow;

  /// No description provided for @bannerBodyActionGrantNever.
  ///
  /// In en, this message translates to:
  /// **'Never'**
  String get bannerBodyActionGrantNever;

  /// No description provided for @bannerBodyActionGrantNow.
  ///
  /// In en, this message translates to:
  /// **'Grant access'**
  String get bannerBodyActionGrantNow;

  /// No description provided for @errorCannotResolveRelativePath.
  ///
  /// In en, this message translates to:
  /// **'Can’t resolve path relative to this document'**
  String get errorCannotResolveRelativePath;

  /// No description provided for @errorPathResolvedToNonFile.
  ///
  /// In en, this message translates to:
  /// **'{path} resolved to a non-file: {resolved}'**
  String errorPathResolvedToNonFile(Object path, Object resolved);

  /// No description provided for @errorUnknownType.
  ///
  /// In en, this message translates to:
  /// **'Unknown type: {type}'**
  String errorUnknownType(Object type);

  /// No description provided for @errorUnexpectedHttpResponse.
  ///
  /// In en, this message translates to:
  /// **'Unexpected HTTP response: {response}'**
  String errorUnexpectedHttpResponse(Object response);
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'ja', 'uk'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'uk':
      return AppLocalizationsUk();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
