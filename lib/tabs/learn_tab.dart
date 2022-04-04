import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noah/constants/color.dart';
import 'package:provider/provider.dart';
import 'course_roadmap.dart';
import 'package:noah/models/domain/course.dart';

// 学習分野のボタンを表示するウィジェット
// TODO 画面遷移先の追加
class CourseButton extends StatelessWidget {
  const CourseButton({Key? key, required this.buttonInfo}) : super(key: key);
  final CourseInformation buttonInfo;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(20),
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => CourseScreen(
                      courseInfo: buttonInfo,
                    )),
          );
        },
        child: SizedBox(
          height: 72,
          child: Column(children: <Widget>[
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.circle,
                    size: 40,
                    color: accentColor,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            buttonInfo.course.title.getByLocale(
                                Localizations.localeOf(context).languageCode),
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        child: Container(
                          margin: const EdgeInsets.all(5),
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            (buttonInfo.progress * 100).toInt().toString() +
                                "%",
                            style: TextStyle(
                              color: buttonInfo.buttonColor,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Container(
              alignment: Alignment.bottomCenter,
              color: accentColor,
              child: LinearProgressIndicator(
                value: buttonInfo.progress,
                color: buttonInfo.buttonColor,
                backgroundColor: plainColor,
                minHeight: 12,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

// Interface of course button
class CourseInformation {
  final Course course;
  final double progress;
  final Color buttonColor;

  CourseInformation(this.course, this.progress, this.buttonColor);
}


class LearnTab extends StatelessWidget {
  final List<CourseWithMetadata> courses;
  const LearnTab({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseButtons = courses
        .map((e) => CourseButton(
            buttonInfo: CourseInformation(e.course, 0.2, themeColor)))
        .toList();

    return ListView(
      children: <Widget>[
        // Text(
        //   'In Progress',
        //   style: Theme.of(context).textTheme.headline4,
        // ),
        // Text(
        //   "Review",
        //   style: Theme.of(context).textTheme.headline4,
        // ),

        // const Expanded(child: CourseButtons(title: "In Progress"),),

        ...courseButtons
      ],
    );
  }
}
