import 'package:flutter/material.dart';

class EmergencyTab extends StatelessWidget {
  const EmergencyTab({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      // Center is a layout widget. It takes a single child and positions it
      // in the middle of the parent.
      child: ListView(

        children: <Widget>[

          Text(
            'Emergency',
            style: Theme.of(context).textTheme.headline4,
          ),

        ],
      ),
    );
  }
}