import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../models/domain/lesson.dart';
import '../models/multilingual_text_util.dart';
import '../components/pages_carousel.dart';

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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: PagesCarousel(
          lesson: lesson,
        ),
      ),
    );
  }
}
