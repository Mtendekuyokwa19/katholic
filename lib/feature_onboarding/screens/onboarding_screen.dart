import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:provider/provider.dart';
import 'package:katholic/feature_onboarding/providers/onboarding_provider.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const Color _primaryColor = Color(0xFF0D59F2);

  final List<Map<String, dynamic>> _onboardingPages = [
    {
      'title': 'Peace in Prayer',
      'description':
          'A minimalist space for your daily spiritual devotion and reflection.',
      'image': 'assets/images/onboarding1.png',
      'buttonText': 'Get Started',
    },
    {
      'title': 'Way of the Cross',
      'description':
          'Experience the stations with scripture and meditation, leading you closer to the Liturgy.',
      'image': 'assets/images/onboarding2.png',
      'buttonText': 'Next',
    },
    {
      'title': 'Sacred Seasons',
      'description':
          'Stay connected with the Liturgical Calendar, daily readings, and the rhythms of the Church.',
      'image': 'assets/images/onboarding3.png',
      'buttonText': 'Get Started',
    },
  ];

  @override
  void initState() {
    super.initState();
    _pageController.addListener(() {
      final page = _pageController.page?.round() ?? 0;
      if (page != _currentPage) {
        setState(() {
          _currentPage = page;
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToNextPage() {
    if (_currentPage < _onboardingPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _completeOnboarding();
    }
  }

  void _goToPreviousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _completeOnboarding() {
    context.read<OnboardingProvider>().completeOnboarding();
    Navigator.of(context).pushReplacementNamed('/home');
  }

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);
    final colors = fTheme.colors;
    final isLastPage = _currentPage == _onboardingPages.length - 1;

    return Scaffold(
      backgroundColor: colors.background,
      body: SafeArea(
        child: Column(
          children: [
            if (_currentPage > 0)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: colors.foreground),
                      onPressed: _goToPreviousPage,
                    ),
                    TextButton(
                      onPressed: _completeOnboarding,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: _primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (_currentPage == 0)
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(FIcons.church, color: _primaryColor, size: 28),
                    const SizedBox(width: 8),
                    Text(
                      'Katholic',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                        color: colors.foreground,
                      ),
                    ),
                  ],
                ),
              ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingPages.length,
                onPageChanged: (page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                itemBuilder: (context, index) {
                  final page = _onboardingPages[index];
                  return _OnboardingPageContent(
                    title: page['title'] as String,
                    description: page['description'] as String,
                    imagePath: page['image'] as String,
                    isFirstPage: index == 0,
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  _PageIndicator(
                    currentPage: _currentPage,
                    totalPages: _onboardingPages.length,
                    activeColor: _primaryColor,
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: _goToNextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: _primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            isLastPage ? 'Get Started' : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward, size: 20),
                        ],
                      ),
                    ),
                  ),
                  if (isLastPage) ...[
                    const SizedBox(height: 12),
                    TextButton(
                      onPressed: _goToPreviousPage,
                      child: Text(
                        'Back',
                        style: TextStyle(
                          color: colors.mutedForeground,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPageContent extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;
  final bool isFirstPage;

  static const Color _primaryColor = Color(0xFF0D59F2);

  const _OnboardingPageContent({
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isFirstPage,
  });

  @override
  Widget build(BuildContext context) {
    final fTheme = FTheme.of(context);
    final colors = fTheme.colors;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: isFirstPage ? 280 : 220,
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _primaryColor.withAlpha(26),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: _primaryColor.withAlpha(51), width: 1),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Center(
                        child: Icon(
                          isFirstPage ? Icons.church : Icons.route,
                          size: 64,
                          color: _primaryColor.withAlpha(128),
                        ),
                      );
                    },
                  ),
                  if (isFirstPage)
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            colors.background.withAlpha(204),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: colors.foreground,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: colors.mutedForeground,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  final int currentPage;
  final int totalPages;
  final Color activeColor;

  const _PageIndicator({
    required this.currentPage,
    required this.totalPages,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        totalPages,
        (index) => AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: currentPage == index ? 24 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: currentPage == index
                ? activeColor
                : activeColor.withAlpha(77),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      ),
    );
  }
}
