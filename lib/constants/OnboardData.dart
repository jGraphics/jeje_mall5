import 'package:flutter/material.dart';

final List<String> titlesList = [
  'Jejelove x HNG task 3',
  'Using API from Timbu',
  'To get product data'
];
final List<String> subtitlesList = [
  'Built with flutter 3 nights long',
  'Debugging the api bugs with slack devs.',
  'See the Products'
];
final List<dynamic> imageList = [
  Icons.school_rounded,
  Icons.code_rounded,
  Icons.shopify
];



class OnbordingContent extends StatelessWidget {
  const OnbordingContent({
    super.key,
    this.isTextOnTop = false,
    required this.title,
    required this.description,
    required this.image,
  });

  final bool isTextOnTop;
  final String title, description, image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),

        if (isTextOnTop)
          OnbordTitleDescription(
            title: title,
            description: description,
          ),
        if (isTextOnTop) const Spacer(),

        /// if you are using SVG then replace [Image.asset] with [SvgPicture.asset]

        Image.asset(
              'assets/images/mall_logo.png',
          height: 250, 
        ),
        if (!isTextOnTop) const Spacer(),
        if (!isTextOnTop)
          const OnbordTitleDescription(
            title: "Find the item you’ve \nbeen looking for",
            description:
                "Here you’ll see rich varieties of goods, carefully classified for seamless browsing experience.",
          ),

        const Spacer(),
      ],
    );
  }
}

class OnbordTitleDescription extends StatelessWidget {
  const OnbordTitleDescription({
    super.key,
    required this.title,
    required this.description,
  });

  final String title, description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 50),
        Text(
          description,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
