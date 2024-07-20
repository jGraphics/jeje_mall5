class OnboardingModel {
  final String backgroundImg;
  final String onBoardMsgHeading;
  final String onBoardMsgBody;
  final String nextMsg;
  final String buttonText;
  final bool imgStretch;

  OnboardingModel({
    required this.backgroundImg,
    required this.onBoardMsgHeading,
    required this.onBoardMsgBody,
    this.nextMsg = 'Skip',
    this.buttonText = 'Next',
    this.imgStretch = false,
  });
}
