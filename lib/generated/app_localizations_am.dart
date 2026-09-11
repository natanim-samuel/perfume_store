// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Amharic (`am`).
class AppLocalizationsAm extends AppLocalizations {
  AppLocalizationsAm([String locale = 'am']) : super(locale);

  @override
  String get appTitle => 'ሜታፎር';

  @override
  String get home => 'መነሻ';

  @override
  String get search => 'ፈልግ';

  @override
  String get categories => 'ምድቦች';

  @override
  String get featured => 'ተመረጡ';

  @override
  String get luxuryPerfumes => 'የቅንጦት\nሽቶዎች';

  @override
  String get discover => 'ለሽቶ ጥበብ ለሚያደንቁ ሰዎች የተሰራውን እጅግ ምርጥ ሽቶ ያግኙ።';

  @override
  String get getStarted => 'ጀምር';

  @override
  String get addToBasket => 'ወደ ቅርጫት ጨምር';

  @override
  String get eauDeParfum => 'የሽቶ ዉሃ';

  @override
  String get allCategory => 'ሁሉም';

  @override
  String get femmeCategory => 'ሴት';

  @override
  String get voyagerCategory => 'ተጓዥ';

  @override
  String get parfumCategory => 'ሽት';

  @override
  String get homeCategory => 'ቤት';

  @override
  String get basket => 'ቅርጫት';

  @override
  String get basketEmpty => 'ቅርጫትዎ ባዶ ነው';

  @override
  String get basketEmptySub => 'ለመጀመር ሽቶ ይጨምሩ';

  @override
  String get cancelAllOrders => 'ሁሉንም ትዕዛዞች ሰርዝ';

  @override
  String get cancelAllConfirm => 'ሁሉንም ዕቃዎች ከቅርጫትዎ ማስወገድ ይፈልጋሉ?';

  @override
  String get checkout => 'ክፍያ';

  @override
  String get no => 'አይ';

  @override
  String get yes => 'አዎ';

  @override
  String totalItems(int count) {
    return '$count ዕቃ';
  }
}
