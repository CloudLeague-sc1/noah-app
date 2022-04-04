import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noah/constants/color.dart';
import 'package:noah/models/domain/lesson.dart';
import 'package:noah/tabs/lesson.dart';
import 'package:noah/tabs/learn_tab.dart';
import 'package:noah/models/multilingual_text_util.dart';

class ProgressContainer extends StatelessWidget {
  const ProgressContainer({
    Key? key,
    required this.name,
    required this.progress,
    required this.courseColor,
  });
  final String name, progress;
  final Color courseColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(5),
      child: Column(
        children: [
          Text(
            progress,
            style: TextStyle(color: courseColor, fontWeight: FontWeight.bold),
          ),
          Text(
            name,
            style: TextStyle(color: courseColor),
          ),
        ],
      ),
    );
  }
}

class LearnDetailInfo extends StatelessWidget {
  const LearnDetailInfo({
    Key? key,
    required this.title,
    required this.streak,
    required this.steps,
    required this.maxSteps,
  });

  final String title;
  final int streak, steps, maxSteps;
  final subColor = accentColor;
  final mainColor = themeColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
              color: Colors.black12,
              blurRadius: 5.0,
              spreadRadius: 1.0,
              offset: Offset(5, 5))
        ],
      ),
      margin: const EdgeInsets.all(20),
      child: Column(children: <Widget>[
        Row(
          children: [
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.all(10),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      ProgressContainer(
                          name: "days streak",
                          progress: streak.toString(),
                          courseColor: subColor),
                      ProgressContainer(
                          name: "steps",
                          progress:
                              steps.toString() + "/" + maxSteps.toString(),
                          courseColor: subColor)
                    ],
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.all(20),
              child: const Icon(
                Icons.favorite,
              ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.bottomCenter,
          child: LinearProgressIndicator(
            value: steps / maxSteps,
            color: mainColor,
            minHeight: 10,
            backgroundColor: Colors.white,
          ),
        ),
      ]),
    );
  }
}

class LessonContent extends StatelessWidget {
  const LessonContent({Key? key, required this.lesson}) : super(key: key);

  final Lesson lesson;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(
                builder: (context) => LessonScreen(
                      lesson: lesson,
                    )),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(children: <Widget>[
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        "Go to the Lesson",
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.chevron_right,
                  ),
                ),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class CourseRoadmap extends StatefulWidget {
  final CourseInformation courseInfo;
  const CourseRoadmap(
      {Key? key, required this.courseInfo, required this.courseColor})
      : super(key: key);
  final Color courseColor;
  @override
  State<StatefulWidget> createState() => _CourseRoadmapState();
}

class _CourseRoadmapState extends State<CourseRoadmap> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    final courseInfo = widget.courseInfo;
    final lessons = courseInfo.course.lessons;
    final lessonButtons = lessons
        .map((e) => Step(
            title: Text(
              getLocaleText(e.title, context),
              style: TextStyle(color: widget.courseColor),
            ),
            content: Container(
              alignment: Alignment.centerLeft,
              child: LessonContent(
                lesson: e,
              ),
            )))
        .toList();

    return Stepper(
      currentStep: _index,
      controlsBuilder: (BuildContext context, ControlsDetails details) {
        return Container();
      },
      onStepCancel: () {
        if (_index > 0) {
          setState(() {
            _index -= 1;
          });
        }
      },
      onStepContinue: () {
        if (_index <= 0) {
          setState(() {
            _index += 1;
          });
        }
      },
      onStepTapped: (int index) {
        setState(() {
          _index = index;
        });
      },
      steps: lessonButtons,
    );
  }
}

class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key, required this.courseInfo}) : super(key: key);

  final CourseInformation courseInfo;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        middle: Text(getLocaleText(courseInfo.course.title, context)),
        border:
            Border(bottom: BorderSide(width: 2.0, color: Colors.grey.shade300)),
      ),
      body: Align(
        alignment: Alignment.topLeft,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: <Widget>[
            LearnDetailInfo(
              title: getLocaleText(courseInfo.course.title, context),
              streak: 10,
              steps: 3,
              maxSteps: 10,
            ),
            CourseRoadmap(
              courseInfo: courseInfo,
              courseColor: themeColor,
            ),
          ],
        ),
      ),
    );
  }
}
