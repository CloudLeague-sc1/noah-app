import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noah/models/domain/lesson.dart';
import 'package:noah/models/multilingual_text_util.dart';
import 'package:carousel_slider/carousel_slider.dart';

class PagesCarousel extends StatefulWidget {
  final List<Widget> pages;
  const PagesCarousel({Key? key, required this.pages}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _PagesCarouselState();
}

class _PagesCarouselState extends State<PagesCarousel> {
  @override
  int current = 0;
  CarouselController carouselController = CarouselController();

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

class LessonScreen extends StatelessWidget {
  const LessonScreen({Key? key, required this.lesson}) : super(key: key);
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        middle: Text(getLocaleText(lesson.title, context)),
        border:
            Border(bottom: BorderSide(width: 2.0, color: Colors.grey.shade300)),
      ),
      body: Align(
        alignment: Alignment.topLeft,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: const PagesCarousel(pages: [
          Text(
            '1',
          ),
          Text(
            '2',
          ),
          Text(
            '3',
          ),
        ]),
      ),
    );
  }
}
