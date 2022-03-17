import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
  int _counter = 0;
  var _title = "potato";
  final List<String> entries = <String>['A', 'B', 'C'];
  final List<int> colorCodes = <int>[600, 500, 100];

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      if (_counter >= 10) {
        _counter = 0;
      } else {
        _counter++;
      }
    });
  }

  void _potatoSalad() {
    setState(() {
      if (_title == "potato") {
        _title = "potato salad";
      } else {
        _title = "potato";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Align(
        alignment: Alignment.topLeft,
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: ListView(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          children: <Widget>[

            Text(
              'In Progress',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              _title,
            ),
            Text(
              "Review",
              style: Theme.of(context).textTheme.headline4,
            ),
            Card(
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
                          Column(
                            children: [
                            Text(
                                "ProgramNameSample",
                              style: Theme.of(context).textTheme.headline6,
                              textAlign: TextAlign.center,
                            ),
                            Text("40%",
                            style: Theme.of(context).textTheme.subtitle1,),
                            ],
                          ),
                        ],),
                        const LinearProgressIndicator(
                          value: 0.4,
                          color: Colors.red,
                          minHeight: 20,
                        ),
                      ]
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _potatoSalad,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
      ),
    );
  }
}
