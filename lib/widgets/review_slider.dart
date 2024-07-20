import 'package:flutter/material.dart';
import 'package:flutter_lorem/flutter_lorem.dart';
import 'package:jeje_mall5/constants/colors.dart';
import 'package:carousel_slider/carousel_slider.dart';

class ReviewSlider extends StatelessWidget {
  final String text1 = lorem(paragraphs: 1, words: 15);
  final String text2 = lorem(paragraphs: 1, words: 24);
  final String text3 = lorem(paragraphs: 1, words: 19);

  ReviewSlider({super.key, required List<String> reviews});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: [
        reviewContainer("Jejelove Roxy", "5 July 2024", text1),
        reviewContainer("DiLo HNG", "6 July 2024", text2),
        reviewContainer("Abbie Flutter", "7 July 2024", text3),
      ],
      options: CarouselOptions(
        initialPage: 0,
        viewportFraction: 1,
        autoPlay: true,
        height: 200,
        autoPlayInterval: const Duration(seconds: 5),
        enlargeCenterPage: true,
        enlargeFactor: 0.8,
        autoPlayCurve: Curves.easeIn,
        disableCenter: true,
      ),
    );
  }

  Widget reviewContainer(String name, String date, String review) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      padding: const EdgeInsets.all(10.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 243, 235, 235),
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.rectangle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: AssetImage("assets/images/hnc.png"),
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                  ),
                  const SizedBox(width: 7),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(.4),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: List.generate(
                  5,
                  (index) => const Icon(
                    Icons.star,
                    color: colorPrimary,
                    size: 30,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            review,
            softWrap: true,
            style: const TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }
}
