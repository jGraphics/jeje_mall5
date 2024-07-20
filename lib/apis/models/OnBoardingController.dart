import 'package:flutter/material.dart';
import 'package:jeje_mall5/constants/bottom_bar.dart';

class OnboardingController extends ChangeNotifier {
  final PageController pageController;

  OnboardingController({required this.pageController});

  void nextPage() {
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
    notifyListeners();
  }

  void navigateToWelcome(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const BottomNav(),
      ),
    );
  }
}
