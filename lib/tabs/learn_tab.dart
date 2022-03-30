import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
                      courseInfo:buttonInfo,
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
                    Icons.emergency,
                    size: 40,
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
                            buttonInfo.course.title.getByLocale(Localizations.localeOf(context).languageCode),
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
              color: Colors.blue,
              child: LinearProgressIndicator(
                value: buttonInfo.progress,
                color: buttonInfo.buttonColor,
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

// Course data sample
// Docs: https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple
// Good Article: https://programming-dojo.com/%E3%80%90flutter%E5%85%A5%E9%96%80%E3%80%91provider%E3%81%AEconsumer%E3%81%AE%E8%AA%AC%E6%98%8E%E3%81%A8%E4%BD%BF%E3%81%84%E6%96%B9/
// class CourseData extends ChangeNotifier {
//   final List<CourseInformation> _courseData = [CourseInformation("Earthquake", 0.4), CourseInformation("TSUNAMI", 0.1)];
//
//   UnmodifiableListView<CourseInformation> get courseData {
//     return UnmodifiableListView(_courseData);
//   }
//
//   void addData(String name, double progress) {
//     _courseData.add(
//       CourseInformation(name, progress),
//     );
//     notifyListeners();
//   }
//
//   void deleteData(CourseInformation courseInformation) {
//     _courseData.remove(courseInformation);
//     notifyListeners();
//   }
//
//   int get dataCount {
//     return _courseData.length;
//   }
// }
//
//
// class CourseButtons extends StatelessWidget {
//   const CourseButtons({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//
//       child: Align(
//         alignment: Alignment.topLeft,
//         child: ListView(
//           children: <Widget>[
//             Text(
//               title,
//               style: Theme.of(context).textTheme.headline4,
//             ),
//             Consumer<CourseData>(
//               builder: (context, courseData, child) {
//                 return ListView.builder(
//                   itemBuilder: (context, index) {
//                     final courseButtonData = courseData.courseData[index];
//                     return CourseButton(buttonInfo: courseButtonData);
//                   },
//                   itemCount: courseData.dataCount,
//                 );
//               },
//             ),
//             CourseButton(buttonInfo: CourseInformation("fire", 0.2))
//           ],
//         ),
//       ),
//     );
//
//   }
// }

class LearnTab extends StatelessWidget {
  final List<CourseWithMetadata> courses;
  const LearnTab({Key? key, required this.courses}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final courseButtons = courses
        .map((e) => CourseButton(
            buttonInfo: CourseInformation(e.course, 0.2, Colors.blue)))
        .toList();

    return Column(
      children: <Widget>[
        Text(
          'In Progress',
          style: Theme.of(context).textTheme.headline4,
        ),
        Text(
          "Review",
          style: Theme.of(context).textTheme.headline4,
        ),

        // const Expanded(child: CourseButtons(title: "In Progress"),),

        ...courseButtons
      ],
    );
  }
}
