# AGENTS.md - Njira ya Mtanda Flutter Project

This file contains guidelines for coding agents working on the Njira ya Mtanda Flutter application, a Catholic daily readings and Way of the Cross app.

## Project Overview

- **Framework**: Flutter with Dart SDK ^3.10.1
- **UI Library**: ForUI (^0.17.0) - Modern Flutter UI components
- **State Management**: Provider (^6.1.5+1)
- **Database**: Sqflite (^2.4.2) for offline storage
- **Architecture**: Feature-based modular structure

## Build, Lint, and Test Commands

### Core Commands

```bash
# Install dependencies
flutter pub get

# Run the app
flutter run -v

```

### Linting and Analysis

```bash
# Run static analysis (linting + type checking)
flutter analyze

# Format code automatically
dart format .

# Fix auto-fixable issues
dart fix --apply
```

### Development Workflow

```bash
# Clean and rebuild
flutter clean && flutter pub get

# Upgrade dependencies
flutter pub upgrade

# Check for outdated packages
flutter pub outdated

# Run with hot reload enabled
flutter run --hot
```

**Note:** You do not need to run `flutter run --debug` to test fixes for build-time errors. Use `flutter analyze` for static analysis instead.

## Code Style Guidelines

### General Principles

- Follow Dart's official style guide: https://dart.dev/guides/language/effective-dart/style
- Use `flutter_lints` rules (configured in `analysis_options.yaml`)
- Prefer functional programming patterns where appropriate
- Write self-documenting code with clear variable/method names
- Keep methods small and focused on single responsibilities
- use snake_case for files.
- in screens folders only one widget should exist if you want to add another widget it should go into the widgets folder and given a name with a names
- A widget should not be nested into 3 levels
- write as if you are an engineer at google.
- use forui components

### Imports

```dart
// 1. Flutter SDK imports first
import 'package:flutter/material.dart';

// 2. Third-party packages (alphabetical)
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';

// 3. Project imports (relative paths, grouped by feature)
// Local imports within same feature
import 'models/reading_model.dart';
import 'widgets/reading_card.dart';

// Imports from other features
import '../../common/database_helper.dart';
import '../../constants/strings.dart';

// 4. Avoid wildcard imports (*) except for constants
// Good
import 'package:njirayamtanda/constants/strings.dart';

// Avoid
import 'package:njirayamtanda/constants/strings.dart' as strings;
```

### Naming Conventions

#### Classes and Types

- Use PascalCase for class names: `CatholicReading`, `WayOfTheCrossProvider`
- Use PascalCase for enums: `enum ReadingType { first, second, gospel }`
- Use PascalCase for typedefs: `typedef ReadingCallback = void Function(Reading);`

#### Variables and Methods

- Use camelCase for variables and methods: `selectedDate`, `getReadingsByDate()`
- Use lowercase with underscores for private members: `_selectedDate`, `_loadReadings()`
- Use descriptive names: `dailyReadings` instead of `data`, `userSelectedDate` instead of `date`

#### Files and Directories

- Use snake_case for file names: `home_screen.dart`, `reading_model.dart`
- Use snake_case for directory names: `feature_home`, `common_models`
- Group related files: models/, providers/, screens/, widgets/ within features

### Code Formatting

#### Indentation and Spacing

- Use 2 spaces for indentation (Dart default)
- Add blank lines between logical sections
- Space after commas, colons, and semicolons
- No trailing whitespace

#### Line Length

- Keep lines under 100 characters when possible
- Break long lines at logical points (commas, operators)
- Use trailing commas in multi-line collections

#### Example Formatting

```dart
// Good: Clear structure with proper spacing
class ReadingCard extends StatelessWidget {
  const ReadingCard({
    required this.reading,
    required this.onTap,
    super.key,
  });

  final CatholicReading reading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FCard(
      title: Text(reading.title),
      subtitle: Text(reading.reference),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(reading.content),
          const SizedBox(height: 16),
          FButton(
            onPress: onTap,
            label: const Text('Read More'),
          ),
        ],
      ),
    );
  }
}

// Avoid: Cramped code without clear separation
class ReadingCard extends StatelessWidget{const ReadingCard({required this.reading,required this.onTap,super.key});final CatholicReading reading;final VoidCallback onTap;@override Widget build(BuildContext context){return FCard(title:Text(reading.title),subtitle:Text(reading.reference),child:Column(children:[Text(reading.content),FButton(onPress:onTap,label:Text('Read More'))]));}}
```

### Type Annotations

#### Always Use Explicit Types

```dart
// Good: Explicit types for clarity
final List<CatholicReading> readings = [];
final Map<String, dynamic> readingData = {};

// Avoid: var when type isn't obvious
var readings = <CatholicReading>[]; // Less clear
```

#### Nullable Types

- Use nullable types explicitly: `String? optionalText`
- Use late for definitely assigned variables: `late String userName;`
- Avoid `!` operator unless absolutely necessary
- Use `required` for named parameters that cannot be null

### Error Handling

#### Try-Catch Patterns

```dart
// Good: Handle specific exceptions
try {
  final readings = await databaseHelper.getReadingsForDate(date);
  return readings;
} on DatabaseException catch (e) {
  // Handle database-specific errors
  debugPrint('Database error: $e');
  return [];
} catch (e) {
  // Handle general errors
  debugPrint('Unexpected error: $e');
  rethrow; // Re-throw for higher-level handling
}
```

#### Null Safety

```dart
// Good: Null-aware operators
final displayName = user?.name ?? 'Anonymous';
final readingCount = readings?.length ?? 0;

// Good: Null checks with early returns
void processReading(CatholicReading? reading) {
  if (reading == null) return;

  // Safe to use reading here
  print(reading.title);
}
```

### State Management with Provider

#### Provider Patterns

```dart
// Consumer widget for scoped access
class ReadingList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DateOnCalenderProvider>(
      builder: (context, dateProvider, child) {
        final readings = ReadingsFns().getReadingsbyDate(
          dateProvider.selectedDate,
        );

        return ListView.builder(
          itemCount: readings.length,
          itemBuilder: (context, index) => ReadingCard(
            reading: readings[index],
            onTap: () => _showReadingDetails(context, readings[index]),
          ),
        );
      },
    );
  }
}

// Provider access in business logic
class ReadingService {
  final DateOnCalenderProvider _dateProvider;

  ReadingService(BuildContext context)
      : _dateProvider = Provider.of<DateOnCalenderProvider>(
          context,
          listen: false,
        );

  List<CatholicReading> getCurrentReadings() {
    return ReadingsFns().getReadingsbyDate(_dateProvider.selectedDate);
  }
}
```

### UI Patterns with ForUI

#### Widget Structure

```dart
// Good: Consistent ForUI usage
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);

    return FScaffold(
      header: FHeader(title: Text(Strings.home)),
      child: SingleChildScrollView(
        child: Column(
          children: [
            FCard(
              title: Text(Strings.wordOfTheDay),
              child: Text('Daily reflection content...'),
            ),
            const SizedBox(height: 16),
            FButton(
              onPress: () => _navigateToReadings(context),
              label: Text(Strings.readings),
            ),
          ],
        ),
      ),
    );
  }
}
```

#### Component Organization

- Group related UI elements in custom widgets
- Use const constructors for stateless widgets
- Extract repeated UI patterns into reusable components
- Follow ForUI component API conventions

### Testing Patterns

#### Widget Testing

```dart
void main() {
  group('HomeScreen', () {
    testWidgets('displays daily readings', (tester) async {
      // Arrange
      final mockProvider = DateOnCalenderProvider();
      mockProvider.setSelectedDate(DateTime(2024, 3, 1));

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider.value(value: mockProvider),
          ],
          child: const MaterialApp(home: HomeScreen()),
        ),
      );

      // Act
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('Daily Reading'), findsOneWidget);
      expect(find.byType(ReadingCard), findsWidgets);
    });

    testWidgets('navigates to reading details on tap', (tester) async {
      // Test navigation behavior
    });
  });
}
```

#### Unit Testing

```dart
void main() {
  group('ReadingsFns', () {
    test('getReadingsbyDate returns correct readings for date', () {
      final readingsFns = ReadingsFns();
      final testDate = DateTime(2024, 12, 25);

      final result = readingsFns.getReadingsbyDate(testDate);

      expect(result.date, equals(testDate));
      expect(result.readings, isNotEmpty);
    });

    test('throws exception for invalid date', () {
      final readingsFns = ReadingsFns();
      final invalidDate = DateTime(2024, 2, 30); // Invalid date

      expect(
        () => readingsFns.getReadingsbyDate(invalidDate),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
```

### Database Operations

#### Sqflite Patterns

```dart
class DatabaseHelper {
  static const _databaseName = 'njirayamtanda.db';
  static const _databaseVersion = 1;

  // Good: Singleton pattern for database access
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE readings (
        id INTEGER PRIMARY KEY,
        date TEXT NOT NULL,
        title TEXT NOT NULL,
        content TEXT NOT NULL
      )
    ''');
  }
}
```

### Asset Management

#### Image and Data Assets

- Store static data in `lib/common/models/` as JSON files
- Reference assets in `pubspec.yaml` with proper paths
- Use consistent naming: snake_case for file names
- Include both English and Chichewa localizations

### Constants and Configuration

#### String Constants

```dart
// Good: Centralized string management
class Strings {
  static const String home = 'Home';
  static const String readings = 'Mawu'; // Chichewa for "Words"
  static const String wayOfTheCross = 'Njira ya mtanda';
}

// Usage
Text(Strings.home)
```

#### Color and Size Constants

```dart
// lib/constants/app_colors.dart
class AppColors {
  static const Color primary = Color(0xFF2E7D32);
  static const Color accent = Color(0xFF4CAF50);
}

// lib/constants/app_sizes.dart
class AppSizes {
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double cardBorderRadius = 12.0;
}
```

### Feature Organization

#### Directory Structure

```
lib/
├── common/                 # Shared utilities, models, services
│   ├── database_helper.dart
│   └── models/
├── constants/              # App-wide constants
│   ├── strings.dart
│   ├── colors.dart
│   └── sizes.dart
├── feature_home/           # Home feature
│   ├── models/
│   ├── providers/
│   ├── screens/
│   ├── widgets/
│   └── functions/
├── feature_way_of_the_cross/
│   └── ...                 # Same structure
└── theme/                  # ForUI theme customizations
```

#### Feature Guidelines

- Keep features independent and self-contained
- Use relative imports within features
- Share common code through `common/` directory
- Follow consistent naming: `feature_[name]/`

### Internationalization

#### Multi-language Support

- Primary language: Chichewa (Malawi)
- Secondary language: English
- Store all user-facing strings in `constants/strings.dart`
- Use descriptive English keys, translate values
- Test UI with both languages enabled

### Performance Considerations

#### Widget Optimization

- Use `const` constructors for static widgets
- Implement `shouldRepaint` for custom painters
- Use `Selector` for fine-grained provider updates
- Avoid unnecessary rebuilds with `Provider.value`

#### Memory Management

- Dispose controllers in `dispose()` method
- Cancel subscriptions and timers
- Use weak references for callbacks when appropriate

### Git Workflow

#### Commit Messages

- Use conventional commits: `feat: add dark mode toggle`
- Keep messages concise but descriptive
- Reference issues: `fix: resolve crash on reading load (#123)`

#### Branch Naming

- Feature branches: `feature/add-search-functionality`
- Bug fixes: `fix/reading-display-crash`
- Hotfixes: `hotfix/critical-database-issue`

### Code Review Checklist

- [ ] Code follows style guidelines
- [ ] All tests pass (`flutter test`)
- [ ] Linting passes (`flutter analyze`)
- [ ] No TODO comments left unresolved
- [ ] Error handling implemented
- [ ] Null safety enforced
- [ ] Performance considerations addressed
- [ ] Documentation updated if needed

---

This guide should be updated as the project evolves. Last updated: March 2026
