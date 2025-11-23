// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Orgro';

  @override
  String get menuItemAppearance => '外観…';

  @override
  String get menuItemClearCache => 'キャッシュを削除';

  @override
  String get menuItemOrgroManual => 'Orgroマニュアル';

  @override
  String get menuItemAbout => 'アプリについて';

  @override
  String get appearanceModeAutomatic => '自動';

  @override
  String get appearanceModeLight => 'ライト';

  @override
  String get appearanceModeDark => 'ダーク';

  @override
  String get snackbarMessageCacheCleared => 'キャッシュを削除しました';

  @override
  String get aboutLinkSupport => 'サポート・お問い合わせ';

  @override
  String get aboutLinkChangelog => '変更履歴';

  @override
  String get buttonOpenFile => 'ファイルを開く';

  @override
  String get buttonOpenOrgroManual => 'Orgroマニュアルを開く';

  @override
  String get buttonOpenOrgManual => 'Orgマニュアルを開く';

  @override
  String get buttonSupport => 'サポート・お問い合わせ';

  @override
  String buttonVersion(Object version) {
    return 'v$version';
  }

  @override
  String get sectionHeaderRecentFiles => '最近のファイル';

  @override
  String get menuItemReaderMode => 'リーダーモード';

  @override
  String get menuItemFullWidth => '画面幅いっぱいで表示';

  @override
  String get menuItemScrollTop => '上へスクロール';

  @override
  String get menuItemScrollBottom => '下へスクロール';

  @override
  String get hintTextSearch => '検索...';

  @override
  String get snackbarMessageNeedsDirectoryPermissions => '相対リンクを解決する権限がありません';

  @override
  String get snackbarActionGrantAccess => '許可する';

  @override
  String get dialogTitleError => 'エラー';

  @override
  String get pageTitleError => 'エラー';

  @override
  String get pageTitleLoading => 'ロード中...';

  @override
  String pageTitleNarrow(Object name) {
    return '$name › narrow';
  }

  @override
  String get bannerBodyRemoteImages => '本ドキュメントにはリモート画像が含まれています。表示しますか？';

  @override
  String get bannerBodyActionShowAlways => '常に表示';

  @override
  String get bannerBodyActionShowNever => '表示しない';

  @override
  String get bannerBodyActionShowOnce => '1 回のみ';

  @override
  String get bannerBodyRelativeLinks => '本ドキュメントには相対リンクが含まれています。アクセスを許可しますか？';

  @override
  String get bannerBodyActionGrantNotNow => '今は許可しない';

  @override
  String get bannerBodyActionGrantNever => '許可しない';

  @override
  String get bannerBodyActionGrantNow => '許可';

  @override
  String get errorCannotResolveRelativePath => '本ドキュメントからの相対パスは解決できません。';

  @override
  String errorPathResolvedToNonFile(Object path, Object resolved) {
    return '$path を解決した結果はファイルではありませんでした。結果: $resolved';
  }

  @override
  String errorUnknownType(Object type) {
    return '不明な型: $type';
  }

  @override
  String errorUnexpectedHttpResponse(Object response) {
    return '予期しない HTTP レスポンス: $response';
  }
}
