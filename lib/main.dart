import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:noah/tabs/setting_tab.dart';
import 'package:noah/tabs/emergency_tab.dart';
import 'package:noah/tabs/learn_tab.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Noah',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.indigo,
      ),
      home: const MyHomePage(title: "NOAH"),
    );
  }
}


// widgetクラスとstateクラスのセットで表される
// widgetクラス
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}


// stateクラス
class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  static const List<Widget> _widgetOptions = <Widget>[
    LearnTab(),
    EmergencyTab(),
    SettingTab(),
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: CupertinoNavigationBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        middle: Text(widget.title),
        border: Border(bottom: BorderSide(width: 2.0, color: Colors.grey.shade300)),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),

    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(Icons.school),
            label:  'Learn'
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.doorbell),
            label: 'Emergency'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Account',
          ),
        ],
        selectedItemColor: Colors.red[900],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }
}
