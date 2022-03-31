import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:noah/models/domain/lesson.dart';

import '../models/domain/page.dart';

import '../components/page_card.dart';
import '../components/content_page_card.dart';
import '../components/quiz_page_card.dart';
import '../components/summary_page_card.dart';

PageCard renderPage(PageBase page, VoidCallback nextPage) {
  if (page is Content) {
    return ContentPageCard(page: page);
  } else if (page is Quiz) {
    return renderQuizPageCard(page, nextPage);
  } else {
    throw Exception('Unknown page type');
  }
}

class PagesCarousel extends StatefulWidget {
  final Lesson lesson;
  const PagesCarousel({Key? key, required this.lesson}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PagesCarouselState();
}

class _PagesCarouselState extends State<PagesCarousel> {
  int current = 0;
  CarouselController carouselController = CarouselController();
  List<Widget> pageWidgets = [];

  @override
  Widget build(BuildContext context) {
    setState(() => {
          pageWidgets = [
            ...widget.lesson.pages.map((e) => renderPage(e, next)).toList(),
            SummaryPageCard(items: widget.lesson.summary)
          ]
        });

    return Column(children: [
      // Carousel
      Expanded(
          //TODO: Using a CarouselSlider just for fun, but maybe it's bad way to display pages
          child: CarouselSlider(
              items: pageWidgets,
              options: CarouselOptions(
                aspectRatio: 0.67,
                enableInfiniteScroll: false,
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
    return current + 1 < pageWidgets.length;
  }

  bool next() {
    if (current + 1 < pageWidgets.length) {
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
