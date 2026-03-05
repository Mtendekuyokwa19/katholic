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
import 'splash_screen.dart';
import 'common/database_helper.dart';
import 'constants/strings.dart';
import 'common/providers/settings_provider.dart';

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
      MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color(0xFF2E7D32)),
          textTheme: GoogleFonts.quicksandTextTheme(
            ThemeData.light().textTheme.apply(
              fontSizeFactor: 1.0,
              fontSizeDelta: 2.0,
            ),
          ),
        ),
        home: const SplashScreen(),
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
        final fTheme = settingsProvider.currentTheme;

        final baseTextTheme = _buildTextTheme(
          fTheme,
          settingsProvider.fontSizeFactor,
        );

        final isDark = fTheme.colors.brightness == Brightness.dark;

        final materialTheme = ThemeData(
          useMaterial3: true,
          brightness: isDark ? Brightness.dark : Brightness.light,
          colorScheme: ColorScheme(
            brightness: isDark ? Brightness.dark : Brightness.light,
            primary: fTheme.colors.primary,
            onPrimary: fTheme.colors.primaryForeground,
            secondary: fTheme.colors.secondary,
            onSecondary: fTheme.colors.secondaryForeground,
            error: fTheme.colors.destructive,
            onError: fTheme.colors.destructiveForeground,
            surface: fTheme.colors.background,
            onSurface: fTheme.colors.foreground,
          ),
          scaffoldBackgroundColor: fTheme.colors.background,
          textTheme: baseTextTheme,
        );

        return MaterialApp(
          supportedLocales: FLocalizations.supportedLocales,
          localizationsDelegates: const [
            ...FLocalizations.localizationsDelegates,
          ],
          theme: materialTheme,
          builder: (_, Widget? child) =>
              FAnimatedTheme(data: fTheme, child: child!),
          home: const RootScreen(),
        );
      },
    );
  }

  TextTheme _buildTextTheme(FThemeData fTheme, double fontSizeFactor) {
    final defaultTextTheme = TextTheme(
      displayLarge: TextStyle(
        fontSize: 57 * fontSizeFactor,
        fontWeight: FontWeight.w400,
        color: fTheme.colors.foreground,
      ),
      displayMedium: TextStyle(
        fontSize: 45 * fontSizeFactor,
        fontWeight: FontWeight.w400,
        color: fTheme.colors.foreground,
      ),
      displaySmall: TextStyle(
        fontSize: 36 * fontSizeFactor,
        fontWeight: FontWeight.w400,
        color: fTheme.colors.foreground,
      ),
      headlineLarge: TextStyle(
        fontSize: 32 * fontSizeFactor,
        fontWeight: FontWeight.w400,
        color: fTheme.colors.foreground,
      ),
      headlineMedium: TextStyle(
        fontSize: 28 * fontSizeFactor,
        fontWeight: FontWeight.w400,
        color: fTheme.colors.foreground,
      ),
      headlineSmall: TextStyle(
        fontSize: 24 * fontSizeFactor,
        fontWeight: FontWeight.w400,
        color: fTheme.colors.foreground,
      ),
      titleLarge: TextStyle(
        fontSize: 22 * fontSizeFactor,
        fontWeight: FontWeight.w500,
        color: fTheme.colors.foreground,
      ),
      titleMedium: TextStyle(
        fontSize: 16 * fontSizeFactor,
        fontWeight: FontWeight.w500,
        color: fTheme.colors.foreground,
      ),
      titleSmall: TextStyle(
        fontSize: 14 * fontSizeFactor,
        fontWeight: FontWeight.w500,
        color: fTheme.colors.foreground,
      ),
      bodyLarge: TextStyle(
        fontSize: 16 * fontSizeFactor,
        fontWeight: FontWeight.w400,
        color: fTheme.colors.foreground,
      ),
      bodyMedium: TextStyle(
        fontSize: 14 * fontSizeFactor,
        fontWeight: FontWeight.w400,
        color: fTheme.colors.foreground,
      ),
      bodySmall: TextStyle(
        fontSize: 12 * fontSizeFactor,
        fontWeight: FontWeight.w400,
        color: fTheme.colors.mutedForeground,
      ),
      labelLarge: TextStyle(
        fontSize: 14 * fontSizeFactor,
        fontWeight: FontWeight.w500,
        color: fTheme.colors.foreground,
      ),
      labelMedium: TextStyle(
        fontSize: 12 * fontSizeFactor,
        fontWeight: FontWeight.w500,
        color: fTheme.colors.foreground,
      ),
      labelSmall: TextStyle(
        fontSize: 11 * fontSizeFactor,
        fontWeight: FontWeight.w500,
        color: fTheme.colors.mutedForeground,
      ),
    );

    return GoogleFonts.quicksandTextTheme(defaultTextTheme).copyWith(
      bodyLarge: GoogleFonts.manrope(textStyle: defaultTextTheme.bodyLarge),
      bodyMedium: GoogleFonts.manrope(textStyle: defaultTextTheme.bodyMedium),
      bodySmall: GoogleFonts.manrope(textStyle: defaultTextTheme.bodySmall),
      labelLarge: GoogleFonts.manrope(textStyle: defaultTextTheme.labelLarge),
      labelMedium: GoogleFonts.manrope(textStyle: defaultTextTheme.labelMedium),
      labelSmall: GoogleFonts.manrope(textStyle: defaultTextTheme.labelSmall),
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
