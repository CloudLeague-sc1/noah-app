import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'course.dart';

// 学習分野のボタンを表示するウィジェット
class DisasterTypeButton extends StatelessWidget {
  const DisasterTypeButton(
      {Key? key, required this.name, required this.progress})
      : super(key: key);
  final String name;
  final double progress;

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
                builder: (context) => const CourseScreen(
                      title: "地震",
                    )),
          );
        },
        child: Container(
          child: Column(children: <Widget>[
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(20),
                  child: const Icon(
                    Icons.emergency,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    children: [
                      Text(
                        name,
                        style: Theme.of(context).textTheme.headline6,
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        (progress * 100).toString() + "%",
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
                value: progress,
                color: Colors.lightGreen,
                minHeight: 20,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class LearnTab extends StatelessWidget {
  const LearnTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: ListView(
        children: <Widget>[
          Text(
            'In Progress',
            style: Theme.of(context).textTheme.headline4,
          ),
          const DisasterTypeButton(
            name: "Earthquake",
            progress: 0.4,
          ),
          Text(
            "Review",
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
