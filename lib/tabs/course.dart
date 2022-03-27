import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noah/tabs/detail_page.dart';

class LearnDetailInfo extends StatelessWidget {
  const LearnDetailInfo({Key? key, required this.title,
    required this. streak, required this.steps,
    required this.maxSteps,
  });

  final String title;
  final int streak, steps, maxSteps;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Column(
          children: <Widget>[
            Row(children: [
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
                    Text("days streak",
                      style: Theme.of(context).textTheme.subtitle1,),
                  ],
                ),
              )
            ],),
            Container(
              alignment: Alignment.bottomCenter,
              color: Colors.blue,
              child: LinearProgressIndicator(
                value: 0.1,
                color: Colors.red,
                minHeight: 20,
              ),
            ),

          ]
      ),
    );
  }

}

class CourseContent extends StatelessWidget {
  const CourseContent({Key? key, required this.title, required this.text}) : super(key: key);
  final String title, text;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: (){
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => LearningScreen(title: title,)),
          );
        },
        child: SizedBox(
          width: 300,
          height: 100,
          child: Column(
              children: <Widget>[
                Row(children: [
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
                          text,
                          style: Theme.of(context).textTheme.bodyText1,
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  )
                ],),

              ]
          ),
        ),
      ),
    );
  }


}

class Course extends StatefulWidget {
  const Course({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _CourseState();

}

class _CourseState extends State<Course> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
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
      steps: [
        Step(title: const Text('地震とは'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: const CourseContent(
                title: "地震とは",
                text: "HogeHoge",
              ),
            )
        ),
        Step(title: const Text('緊急地震速報'),
            content: Container(
              alignment: Alignment.centerLeft,
              child: const CourseContent(
                title: "緊急地震速報",
                text: "Hogehoge",
              ),
            )
        ),
      ],

    );
  }
}


class CourseScreen extends StatelessWidget {
  const CourseScreen({Key? key, required this.title}) : super(key: key);

  final String title;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CupertinoNavigationBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        middle: Text(title),
        border: Border(bottom: BorderSide(width: 2.0, color: Colors.grey.shade300)),
      ),
      body: Align(
        alignment: Alignment.topLeft,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          children: <Widget>[
            LearnDetailInfo(title: title, streak: 10, steps: 3, maxSteps: 10,),
            const Course(),

          ],
        ),
      ),
    );

  }
}