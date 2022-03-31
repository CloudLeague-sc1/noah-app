import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noah/components/summary_page_card.dart';
import '../models/domain/lesson.dart';
import '../models/multilingual_text_util.dart';
import '../components/pages_carousel.dart';
import '../models/domain/page.dart';

import '../components/page_card.dart';
import '../components/content_page_card.dart';
import '../components/quiz_page_card.dart';

PageCard renderPage(PageBase page) {
  if (page is Content) {
    return ContentPageCard(page: page);
  } else if (page is Quiz) {
    return renderQuizPageCard(page);
  } else {
    throw Exception('Unknown page type');
  }
}

class LessonScreen extends StatelessWidget {
  const LessonScreen({Key? key, required this.lesson}) : super(key: key);
  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    final pages = [
      ...lesson.pages.map(renderPage).toList(),
      SummaryPageCard(items: lesson.summary)
    ];

    return Scaffold(
      appBar: CupertinoNavigationBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        middle: Text(getLocaleText(lesson.title, context)),
        border:
            Border(bottom: BorderSide(width: 2.0, color: Colors.grey.shade300)),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: PagesCarousel(pages: pages),
      ),
    );
  }
}
