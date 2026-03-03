import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:flutter/services.dart';
import 'package:njirayamtanda/constants/strings.dart';
import 'package:njirayamtanda/feature_home/providers/date_on_calender_provider.dart';
import 'package:njirayamtanda/feature_home/screens/home_screen.dart';
import 'package:njirayamtanda/feature_way_of_the_cross/screens/way_of_the_cross_screen.dart';
import 'package:njirayamtanda/feature_more/screens/more_screen.dart';
import 'package:njirayamtanda/common/database_helper.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dbHelper = DatabaseHelper.instance;
  final count = await dbHelper.getMassCount();

  if (count == 0) {
    final jsonString = await rootBundle.loadString(
      'lib/common/models/readings_2026.json',
    );
    await dbHelper.loadFromReadings2026Json(jsonString);
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => DateOnCalenderProvider()),
      ],
      child: Application(),
    ),
  );
}

class Application extends StatelessWidget {
  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    /// Try changing this and hot reloading the application.
    ///
    /// To create a custom theme:
    /// ```shell
    /// dart forui theme create [theme template].
    /// ```
    final theme = FThemes.green.dark;

    return MaterialApp(
      // TODO: replace with your application's supported locales.
      supportedLocales: FLocalizations.supportedLocales,
      // TODO: add your application's localizations delegates.
      localizationsDelegates: const [...FLocalizations.localizationsDelegates],
      // MaterialApp's theme is also animated by default with the same duration and curve.
      // See https://api.flutter.dev/flutter/material/MaterialApp/themeAnimationStyle.html for how to configure this.
      //
      // There is a known issue with implicitly animated widgets where their transition occurs AFTER the theme's.
      // See https://github.com/duobaseio/forui/issues/670.
      theme: theme.toApproximateMaterialTheme(),
      builder: (_, child) => FAnimatedTheme(data: theme, child: child!),
      // You can also replace FScaffold with Material Scaffold.
      home: RootScreen(),
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  final _headers = [
    FHeader(title: Text(Strings.home)),
    FHeader(title: Text(Strings.search)),
    FHeader(title: Text(Strings.wayofthecross)),
    FHeader(
      title: Text(Strings.more),
      suffixes: [
        FHeaderAction(icon: const Icon(FIcons.ellipsis), onPress: () {}),
      ],
    ),
  ];
  final _content = [
    SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: const [HomeScreen()],
      ),
    ),
    const Column(
      mainAxisAlignment: .center,
      children: [Text('Categories Placeholder')],
    ),
    const Column(
      mainAxisAlignment: .center,
      children: [Text('Search Placeholder')],
    ),

    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [Text('Search Placeholder')],
    ),

    const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [WayOfTheCrossScreen()],
    ),

    const MoreScreen(),
  ];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return FScaffold(
      header: _index == 2 || _index == 3 ? null : _headers[_index],
      child: _content[_index],
      footer: FBottomNavigationBar(
        onChange: (index) => setState(() => _index = index),
        children: [
          FBottomNavigationBarItem(
            icon: Icon(FIcons.house),
            label: Text(Strings.home),
          ),
          FBottomNavigationBarItem(
            icon: Icon(FIcons.search),
            label: Text(Strings.search),
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
