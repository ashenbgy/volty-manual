// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Volty Manual';

  @override
  String get welcomeBack => 'Welcome back,';

  @override
  String get whatToFind => 'What would you like to find today?';

  @override
  String get explore => 'Explore';

  @override
  String get exploreSubtitle => 'Browse full manual';

  @override
  String get search => 'Search';

  @override
  String get searchSubtitle => 'Find parts quickly';

  @override
  String get favorites => 'Favorites';

  @override
  String get favoritesSubtitle => 'Saved items';

  @override
  String get settings => 'Settings';

  @override
  String get settingsSubtitle => 'App preferences';

  @override
  String get searchHint => 'Search by part name or code...';

  @override
  String get noPartsFound => 'No parts found';

  @override
  String get subTopics => 'Sub Topics';

  @override
  String get searchSubTopics => 'Search sub topics...';

  @override
  String get noMatchingTopics => 'No matching topics';

  @override
  String get manualPage => 'Manual Page';

  @override
  String get about => 'About';

  @override
  String get version => 'Version';

  @override
  String get aboutDescription =>
      'A premium offline manual viewer with search capabilities, built elegantly with Flutter.';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get sinhala => 'සිංහල (Sinhala)';

  @override
  String get noFavoritesYet => 'No favorites yet.';

  @override
  String get featureComingSoon => 'Feature coming soon!';
}
