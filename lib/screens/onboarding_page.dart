import '../constants/colors.dart';
import 'package:flutter/material.dart';
import '../model/onboarding_model.dart';
import '../apis/models/OnBoardingController.dart';

class OnboardingScreenUtil extends StatelessWidget {
  final OnboardingModel onboardingModel;
  final OnboardingController controller;

  const OnboardingScreenUtil({
    super.key,
    required this.onboardingModel,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('./assets/images/hnc.png'),
                fit: onboardingModel.imgStretch ? BoxFit.fill : BoxFit.contain,
              ),
            ),
          ),
          Container(
            height: 400,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0x007d77ee),
                  kPrimaryColor,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                stops: [0.2, 0.4],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                onboardingModel.onBoardMsgHeading,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  wordSpacing: 3,
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                onboardingModel.onBoardMsgBody,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              GestureDetector(
                onTap: () {
                  controller.navigateToWelcome(context);
                },
                child: Text(
                  onboardingModel.nextMsg,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: Row(
                        children: List.generate(5, (index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            child: Container(
                              height: 5.0,
                              width: 22.0,
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.5),
                                borderRadius: const BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                          );
                        }),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        if (onboardingModel.buttonText == 'Next') {
                          controller.nextPage();
                        } else {
                          controller.navigateToWelcome(context);
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 10.0,
                        ),
                        child: Row(
                          children: [
                            Text(
                              onboardingModel.buttonText,
                              style: const TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.arrow_forward_ios,
                              color: kPrimaryColor,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
