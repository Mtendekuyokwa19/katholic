import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:njirayamtanda/constants/app_sizes.dart';
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
    final FThemeData baseTheme = FThemes.green.dark;

    // Get the approximate Material theme and customize the text theme
    final ThemeData materialTheme = baseTheme
        .toApproximateMaterialTheme()
        .copyWith(
          textTheme: GoogleFonts.crimsonTextTextTheme(
            baseTheme.toApproximateMaterialTheme().textTheme,
          ),
        );

    final FThemeData theme = baseTheme.copyWith();

    return MaterialApp(
      supportedLocales: FLocalizations.supportedLocales,
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      theme: materialTheme,
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
  static const List<Widget> _content = <Widget>[
    HomeScreen(),
    WayOfTheCrossScreen(),
    MoreScreen(),
  ];

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return FScaffold(
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
      child: Container(
        padding: EdgeInsets.fromLTRB(0, AppSizes.s12, 0, 0),
        child: _content[_index],
      ),
    );
  }
}
