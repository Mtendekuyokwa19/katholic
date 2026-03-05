import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:forui/forui.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:katholic/common/notification_service.dart';
import 'package:katholic/constants/app_sizes.dart';
import 'package:katholic/feature_home/screens/home_screen.dart';
import 'package:katholic/feature_more/screens/more_screen.dart';
import 'package:katholic/feature_way_of_the_cross/screens/way_of_the_cross_screen.dart';
import 'package:provider/provider.dart';
import 'common/database_helper.dart';
import 'constants/strings.dart';
import 'feature_home/providers/date_on_calender_provider.dart';
import 'feature_way_of_the_cross/providers/way_of_the_cross_provider.dart';
import 'common/providers/settings_provider.dart';
import 'common/providers/home_widget_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.initialize();

  try {
    final DatabaseHelper dbHelper = DatabaseHelper.instance;
    final int count = await dbHelper.getMassCount();

    if (count == 0) {
      final String jsonString = await rootBundle.loadString(
        'lib/common/models/readings_2026.json',
      );
      await dbHelper.loadFromReadings2026Json(jsonString);
    }

    await NotificationService.scheduleDailySaintNotification();

    runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider<SettingsProvider>(
            create: (_) => SettingsProvider(),
          ),
          ChangeNotifierProvider<DateOnCalenderProvider>(
            create: (_) => DateOnCalenderProvider(),
          ),
          ChangeNotifierProvider<WayOfTheCrossProvider>(
            create: (_) => WayOfTheCrossProvider(),
          ),
          ChangeNotifierProvider<HomeWidgetProvider>(
            create: (_) => HomeWidgetProvider(),
          ),
        ],
        child: const Application(),
      ),
    );
  } catch (e) {
    debugPrint('Error initializing app: $e');
    runApp(
      const MaterialApp(
        home: Scaffold(body: Center(child: Text(Strings.errorLoadingApp))),
      ),
    );
  }
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final settingsProvider = Provider.of<SettingsProvider>(
        context,
        listen: false,
      );
      settingsProvider.loadSettings();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsProvider>(
      builder: (context, settingsProvider, child) {
        final baseTheme = settingsProvider.currentTheme;

        final baseTextTheme = baseTheme
            .toApproximateMaterialTheme()
            .textTheme
            .apply(
              fontSizeFactor: settingsProvider.fontSizeFactor,
              fontSizeDelta: 2.0,
            );

        final materialTextTheme = GoogleFonts.quicksandTextTheme(baseTextTheme)
            .copyWith(
              bodyLarge: GoogleFonts.manrope(
                textStyle: baseTextTheme.bodyLarge,
              ),
              bodyMedium: GoogleFonts.manrope(
                textStyle: baseTextTheme.bodyMedium,
              ),
              bodySmall: GoogleFonts.manrope(
                textStyle: baseTextTheme.bodySmall,
              ),
              labelLarge: GoogleFonts.manrope(
                textStyle: baseTextTheme.labelLarge,
              ),
              labelMedium: GoogleFonts.manrope(
                textStyle: baseTextTheme.labelMedium,
              ),
              labelSmall: GoogleFonts.manrope(
                textStyle: baseTextTheme.labelSmall,
              ),
            );

        final ThemeData materialTheme = baseTheme
            .toApproximateMaterialTheme()
            .copyWith(textTheme: materialTextTheme);

        final FThemeData theme = baseTheme.copyWith();

        return MaterialApp(
          supportedLocales: FLocalizations.supportedLocales,
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          theme: materialTheme,
          builder: (_, Widget? child) =>
              FAnimatedTheme(data: theme, child: child!),
          home: const RootScreen(),
        );
      },
    );
  }
}

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  static final List<Widget> _content = <Widget>[
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

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  Future<void> _navigateToHome() async {
    await Future.delayed(const Duration(seconds: 2));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const RootScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FScaffold(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/appIcon.png', width: 120, height: 120),
            const SizedBox(height: 16),
            Text(
              Strings.appName,
              style: GoogleFonts.quicksand(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              Strings.catholicApp,
              style: GoogleFonts.manrope(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }
}
