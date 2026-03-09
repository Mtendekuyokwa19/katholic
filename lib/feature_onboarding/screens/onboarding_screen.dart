import 'package:flutter/material.dart';
import 'package:forui/forui.dart';
import 'package:katholic/constants/strings.dart';
import 'package:katholic/feature_onboarding/widgets/onboarding_page.dart';
import 'package:katholic/l10n/app_localizations.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, String>> _onboardingPages = [
    {
      'title': 'Welcome to Katholic App',
      'description': 'Discover daily Catholic readings and spiritual guidance',
      'image': 'assets/images/onboarding1.png',
    },
    {
      'title': 'Way of the Cross',
      'description': 'Follow the stations of the cross with reflections',
      'image': 'assets/images/onboarding2.png',
    },
    {
      'title': 'Personalized Experience',
      'description': 'Customize your spiritual journey with our app',
      'image': 'assets/images/onboarding3.png',
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0.0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
        );

    _animationController.forward();

    _pageController.addListener(() {
      if (_pageController.page?.round() != _currentPage) {
        setState(() {
          _currentPage = _pageController.page!.round();
        });
        _animationController.reset();
        _animationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return FScaffold(
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _onboardingPages.length,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              itemBuilder: (context, index) {
                return FadeTransition(
                  opacity: _fadeAnimation,
                  child: SlideTransition(
                    position: _slideAnimation,
                    child: OnboardingPage(
                      title: _onboardingPages[index]['title']!,
                      description: _onboardingPages[index]['description']!,
                      imagePath: _onboardingPages[index]['image']!,
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      _onboardingPages.length,
                      (index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0),
                        child: AnimatedScale(
                          duration: const Duration(milliseconds: 200),
                          scale: _currentPage == index ? 1.2 : 1.0,
                          child: IconButton(
                            icon: Icon(
                              _currentPage == index
                                  ? Icons.circle
                                  : Icons.circle_outlined,
                              size: 12,
                              color: _currentPage == index
                                  ? Theme.of(context).colorScheme.primary
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _currentPage == _onboardingPages.length - 1
                      ? 200
                      : 150,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentPage == _onboardingPages.length - 1) {
                        // Navigate to home screen
                        Navigator.of(context).pushReplacementNamed('/home');
                      } else {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
                    },
                    child: Text(
                      _currentPage == _onboardingPages.length - 1
                          ? localizations.helloWorld
                          : Strings.next,
                    ),
                  ),
                ),
                if (_currentPage < _onboardingPages.length - 1)
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/home');
                    },
                    child: Text(Strings.skip),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
