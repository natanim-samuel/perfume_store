// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'METAPHORE';

  @override
  String get home => 'Home';

  @override
  String get search => 'Search';

  @override
  String get categories => 'Categories';

  @override
  String get featured => 'Featured';

  @override
  String get luxuryPerfumes => 'Luxury\nPerfumes';

  @override
  String get discover =>
      'Discover the finest fragrances, crafted for those who appreciate the art of scent.';

  @override
  String get getStarted => 'Get Started';

  @override
  String get addToBasket => 'Add to basket';

  @override
  String get eauDeParfum => 'EAU DE PARFUM';

  @override
  String get allCategory => 'ALL';

  @override
  String get femmeCategory => 'FEMME';

  @override
  String get voyagerCategory => 'VOYAGER';

  @override
  String get parfumCategory => 'PARFUM';

  @override
  String get homeCategory => 'HOME';

  @override
  String get basket => 'BASKET';

  @override
  String get basketEmpty => 'Your basket is empty';

  @override
  String get basketEmptySub => 'Add a fragrance to get started';

  @override
  String get cancelAllOrders => 'Cancel All Orders';

  @override
  String get cancelAllConfirm =>
      'Are you sure you want to remove all items from your basket?';

  @override
  String get checkout => 'CHECKOUT';

  @override
  String get no => 'No';

  @override
  String get yes => 'Yes';

  @override
  String totalItems(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'items',
      one: 'item',
    );
    return '$count $_temp0';
  }
}
