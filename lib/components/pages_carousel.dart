import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PagesCarousel extends StatefulWidget {
  final List<Widget> pages;
  const PagesCarousel({Key? key, required this.pages}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PagesCarouselState();
}

class _PagesCarouselState extends State<PagesCarousel> {
  int current = 0;
  CarouselController carouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      // Carousel
      CarouselSlider(
          items: widget.pages,
          options: CarouselOptions(
            aspectRatio: 2.0,
            enlargeCenterPage: true,
            onPageChanged: (index, reason) {
              setState(() {
                current = index;
              });
            },
          ),
          carouselController: carouselController),
      // Page controller
      Row(
        children: [
          TextButton(
            onPressed: !tryPrev() ? null : prev,
            child: const Text('<'),
          ),
          TextButton(
            onPressed: !tryNext() ? null : next,
            child: const Text('>'),
          )
        ],
      )
    ]);
  }

  bool tryNext() {
    return current + 1 < widget.pages.length;
  }

  bool next() {
    if (current + 1 < widget.pages.length) {
      current++;
      carouselController.nextPage();
    }
    return tryNext();
  }

  bool tryPrev() {
    return current - 1 >= 0;
  }

  bool prev() {
    if (current > 0) {
      carouselController.previousPage();
      current--;
    }
    return tryPrev();
  }
}
