import 'package:flutter/material.dart';

// 学習分野のボタンを表示するウィジェット
class DisasterTypeButton extends StatelessWidget {
  const DisasterTypeButton({Key? key, required this.name, required this.progress}) : super(key: key);
  final String name;
  final double progress;



  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.blue.withAlpha(30),
        onTap: (){
          debugPrint("Hoge");
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
                          name,
                          style: Theme.of(context).textTheme.headline6,
                          textAlign: TextAlign.left,
                        ),
                        Text((progress*100).toString() + "%",
                          style: Theme.of(context).textTheme.subtitle1,),
                      ],
                    ),
                  )
                ],),
                Container(
                  alignment: Alignment.bottomCenter,
                  color: Colors.blue,
                  child: LinearProgressIndicator(
                    value: progress,
                    color: Colors.red,
                    minHeight: 20,
                  ),
                ),

              ]
          ),
        ),
      ),
    );
  }
}


class LearnScreen extends StatelessWidget {
  const LearnScreen({Key? key}) : super(key: key);


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
              name: "Hey",
              // onPress: (){debugPrint("ege");},
              progress: 0.4
          ),
          // Text(
          //   _title,
          // ),
          Text(
            "Review",
            style: Theme.of(context).textTheme.headline4,
          ),

        ],
      ),
    );
  }
}