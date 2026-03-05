// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get helloWorld => 'Bonjour le monde !';

  @override
  String greeting(String userName) {
    return 'Bonjour $userName';
  }

  @override
  String nWombats(num count) {
    final intl.NumberFormat countNumberFormat = intl.NumberFormat.compact(
      locale: localeName,
    );
    final String countString = countNumberFormat.format(count);

    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$countString wombats',
      one: '1 wombat',
      zero: 'aucun wombat',
    );
    return '$_temp0';
  }
}
