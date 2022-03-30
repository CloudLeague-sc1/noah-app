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
      Expanded(
          child: CarouselSlider(
              items: widget.pages,
              options: CarouselOptions(
                enlargeCenterPage: true,
                onPageChanged: (index, reason) {
                  setState(() {
                    current = index;
                  });
                },
              ),
              carouselController: carouselController)),
      // Page controller
      Row(
        children: [
          PageScrollButton(
              onPressed: !tryPrev() ? null : prev, icon: Icons.arrow_back_ios),
          const Spacer(),
          PageScrollButton(
              onPressed: !tryNext() ? null : next,
              icon: Icons.arrow_forward_ios),
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

class PageScrollButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData icon;
  const PageScrollButton(
      {Key? key, required this.onPressed, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 4),
        child: IconButton(
          onPressed: onPressed,
          icon: Icon(icon),
        ));
  }
}
