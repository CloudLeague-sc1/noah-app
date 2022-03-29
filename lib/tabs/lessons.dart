import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noah/models/domain/lesson.dart';
import 'package:noah/tabs/detail_page.dart';
import 'package:noah/tabs/learn_tab.dart';
import 'package:noah/models/multilingual_text_util.dart';

// TODO change class name

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

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Column(children: <Widget>[
        Row(
          children: [
            Container(
              margin: const EdgeInsets.all(20),
              child: const Icon(
                Icons.favorite,
              ),
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.headline6,
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "days streak",
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                ],
              ),
            )
          ],
        ),
        Container(
          alignment: Alignment.bottomCenter,
          color: Colors.blue,
          child: LinearProgressIndicator(
            value: 0.1,
            color: Colors.red,
            minHeight: 20,
          ),
        ),
      ]),
    );
  }
}

class LessonContent extends StatelessWidget {
  const LessonContent({Key? key, required this.lesson})
      : super(key: key);

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
                builder: (context) => LearningScreen(
                      title: getLocaleText(lesson.title,context),
                    )),
          );
        },
        child: SizedBox(
          width: 300,
          height: 100,
          child: Column(children: <Widget>[
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.favorite,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Text(
                        "Foobar",
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                )
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

  const CourseRoadmap({Key? key,required this.courseInfo}) : super(key: key);
  @override
  State<StatefulWidget> createState() => _CourseRoadmapState();
}

class _CourseRoadmapState extends State<CourseRoadmap> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {

    final courseInfo = widget.courseInfo;
    final lessons = courseInfo.course.lessons;
    final lessonButtons=lessons.map((e) =>  Step(
            title: Text(getLocaleText(e.title, context)),
            content: Container(
              alignment: Alignment.centerLeft,
              child: LessonContent(
                lesson: e,
              ),
            ))).toList();

    return Stepper(
      currentStep: _index,
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
        middle: Text(getLocaleText(courseInfo.course.title,context)),
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
              title: getLocaleText(courseInfo.course.title,context),
              streak: 10,
              steps: 3,
              maxSteps: 10,
            ),
            CourseRoadmap(courseInfo:courseInfo),
          ],
        ),
      ),
    );
  }
}
