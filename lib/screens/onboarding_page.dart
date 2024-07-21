import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../model/onboarding_model.dart';
import 'package:jeje_mall5/constants/colors.dart';
import '../apis/models/onboarding_controller.dart';
import 'package:jeje_mall5/constants/bottom_bar.dart';

class OnboardingScreen extends StatelessWidget {
  final List<OnboardingModel> onboardingPages = [
    OnboardingModel(
      title: 'Welcome to Jejelove',
      description: 'Experience seamless shopping like never before!',
      lottieAnimation: 'https://lottie.host/563e9f01-68a5-41e9-8091-a179c4c0c58e/mC8KBtjihw.json',
    ),
    OnboardingModel(
      title: 'Discover Products',
      description: 'Find the best products curated just for you!',
      lottieAnimation: 'https://lottie.host/b907bf8c-4500-42d8-ae05-274391f1b8ff/X4EB0jbMT4.json',
    ),
    OnboardingModel(
      title: 'Fast and Secure',
      description: 'Enjoy fast and secure transactions.',
      lottieAnimation: 'https://lottie.host/3bdd3a8b-50ff-494a-a7e7-e7641bbfdc21/frCrBVvOnl.json',
    ),
  ];

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<OnboardingController>(
        builder: (context, controller, child) {
          return Stack(
            children: [
              PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) {
                  controller.currentPage = index;
                  controller.notifyListeners();
                },
                itemCount: onboardingPages.length,
                itemBuilder: (context, index) {
                  final page = onboardingPages[index];
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Lottie.network(page.lottieAnimation),
                      const SizedBox(height: 18),
                      Text(
                        page.title,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        page.description,
                        style: const TextStyle(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  );
                },
              ),
              Positioned(
                bottom: 30,
                left: 20,
                right: 20,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.skipToEnd();
                      },
                      child: const Text('Skip'),
                    ),
                    Row(
                      children: List.generate(
                        onboardingPages.length,
                        (index) => AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          margin: const EdgeInsets.symmetric(horizontal: 3),
                          width: controller.currentPage == index ? 12 : 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: controller.currentPage == index
                                ? colorPrimary
                                : Colors.grey,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (controller.currentPage == onboardingPages.length - 1) {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BottomNav(),
                            ),
                          );
                        } else {
                          controller.nextPage();
                        }
                      },
                      child: Text(
                        controller.currentPage == onboardingPages.length - 1
                            ? 'Start'
                            : 'Next',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}