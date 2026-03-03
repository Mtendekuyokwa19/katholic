import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';

import 'common/database_helper.dart';
import 'constants/strings.dart';
import 'feature_home/providers/date_on_calender_provider.dart';
import 'feature_home/screens/home_screen.dart';
import 'feature_more/screens/more_screen.dart';
import 'feature_way_of_the_cross/providers/way_of_the_cross_provider.dart';
import 'feature_way_of_the_cross/screens/way_of_the_cross_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    final int count = await dbHelper.getMassCount();

    if (count == 0) {
      final String jsonString = await rootBundle.loadString(
        'lib/common/models/readings_2026.json',
      );
      await dbHelper.loadFromReadings2026Json(jsonString);
    }

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<DateOnCalenderProvider>(
            create: (_) => DateOnCalenderProvider(),
          ),
          ChangeNotifierProvider<WayOfTheCrossProvider>(
            create: (_) => WayOfTheCrossProvider(),
          ),
        ],
        child: const Application(),
      ),
    );
  } catch (e) {
    debugPrint('Error initializing app: $e');
    runApp(
      const MaterialApp(
        home: Scaffold(
          body: Center(child: Text('Error loading app. Please restart.')),
        ),
      ),
    );
  }
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    final FThemeData theme = FThemes.green.dark;

    return MaterialApp(
      supportedLocales: FLocalizations.supportedLocales,
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      theme: theme.toApproximateMaterialTheme(),
      builder: (_, Widget? child) => FAnimatedTheme(data: theme, child: child!),
      home: const RootScreen(),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  static final List<FHeader?> _headers = <FHeader?>[
    null,
    null,
    FHeader(title: Text(Strings.wayofthecross)),
    FHeader(
      title: Text(Strings.more),
      suffixes: [FHeaderAction(icon: Icon(FIcons.ellipsis), onPress: () {})],
    ),
  ];

  static const List<Widget> _content = <Widget>[
    HomeScreen(),
    WayOfTheCrossScreen(),
    MoreScreen(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: _headers[_index],
      child: _content[_index],
      footer: FBottomNavigationBar(
        onChange: (int index) => setState(() => _index = index),
        children: [
          FBottomNavigationBarItem(
            icon: Icon(FIcons.house),
            label: Text(Strings.home),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.cross),
            label: Text(Strings.wayofthecross),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.personStanding),
            label: Text(Strings.more),
          ),
        ],
      ),
    );
  }
}
