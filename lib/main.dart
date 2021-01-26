import 'dart:math' as math;

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

enum Color { red, green, blue }

extension ColorExtension on Color {
  String get name {
    switch (this) {
      case Color.red:
        return 'red';
        break;
      case Color.green:
        return 'green';
        break;
      case Color.blue:
        return 'blue';
        break;
    }
    // 省略
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
        primarySwatch: Colors.blue,
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  Color _colors = Color.red;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
      print(getRandomColorName());
    });
  }

  String getRandomColorName() {
    var colors = Color.values;
    var rand = math.Random();
    var color = colors[rand.nextInt(3)];
    return color.name;
    // enumの分岐は以下のような感じ
    // switch (color) {
    //   case Color.red:
    //     break;
    // }
  }

  // 同じ意味
  bool isEven(int number) {
    return number / 2 == 0;
  }

  // 同じ意味
  bool isEven2(int number) => number / 2 == 0;

  // デフォルトパラメータ
  void decorateText({bool isBold = false}) {
    // decorate
  }

  // getter
  int get counter => _counter;

  // setter
  set counter(int count) => _counter = count;

  void addListTest() {
    var list = List();
    list.add(1);
    list.add(2);
    list.add(3);

    list..add(4)..add(5)..add(6);

    var _ = List()..add(1)..add(2)..add(3);
  }

  void combineListTest() {
    var list1 = List();
    var list2 = List()..add(1)..add(2)..add(3);
    var list3 = [list1, ...list2];
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
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter times',
              style: Theme.of(context).textTheme.headline4,
            ),
            if (_counter >= 3)
              Text(
                'yeahh',
                style: Theme.of(context).textTheme.headline6,
              ),
            RaisedButton(
              onPressed: () async {
                var message = await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) {
                        return SecondPage('Close second');
                      },
                      fullscreenDialog: true),
                );
                print(message);
              },
              child: Text('Push Second'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SecondPage extends StatelessWidget {
  final String firstText;

  SecondPage(this.firstText);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('yeaaah')),
      body: Center(
        child: Column(
            // Columnは何も指定しないと、heightがmatch_parentになってるため指定しないと上部にくっついてしまう
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RaisedButton(
                onPressed: () {
                  Navigator.pop(context, 'moemoekyun');
                },
                child: Text(firstText),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return ThirdPage('second');
                    },
                  ));
                },
                child: Text('Push third'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return ThirdPage('second');
                    },
                  ));
                },
                child: Text('Replace to third'),
              ),
              Icon(Icons.insert_comment),
              Container(
                  color: Colors.red,
                  padding: EdgeInsets.all(32),
                  width: 320,
                  height: 320,
                  child: Image.network(
                      'https://i.pinimg.com/564x/e1/0e/77/e10e77ecf16151fe4ff92b1d1fa3f80e.jpg'))
            ]),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  final String secondText;

  ThirdPage(this.secondText);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(secondText)),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Close Third'),
        ),
      ),
    );
  }
}
