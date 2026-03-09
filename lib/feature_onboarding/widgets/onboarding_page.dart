import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Hero(
              tag: 'onboarding_image_$imagePath',
              child: Image.asset(imagePath, fit: BoxFit.contain),
            ),
          ),
          const SizedBox(height: 32),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 500),
            style: Theme.of(context).textTheme.headlineMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Text(title, textAlign: TextAlign.center),
          ),
          const SizedBox(height: 16),
          AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 500),
            style: Theme.of(context).textTheme.bodyLarge!,
            child: Text(description, textAlign: TextAlign.center),
          ),
        ],
      ),
    );
  }
}
