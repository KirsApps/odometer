import 'package:flutter/material.dart';
import 'package:odometer/odometer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Odometer Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Odometer Demo Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  int _counter = 10000;
  AnimationController? animationController;
  late Animation<OdometerNumber> animation;
  void _incrementCounter() {
    setState(() {
      _counter += 88;
    });
  }

  @override
  void initState() {
    animationController =
        AnimationController(duration: Duration(seconds: 2), vsync: this);
    animation =
        OdometerTween(begin: OdometerNumber(10000), end: OdometerNumber(12000))
            .animate(CurvedAnimation(
                curve: Curves.easeIn, parent: animationController!));
    super.initState();
  }

  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            AnimatedSlideOdometerNumber(
                letterWidth: 20,
                odometerNumber: OdometerNumber(_counter),
                duration: Duration(seconds: 1),
                numberTextStyle: TextStyle(fontSize: 20)),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: AnimatedSlideOdometerTransition(
                letterWidth: 20,
                odometerAnimation: animation,
                numberTextStyle: TextStyle(fontSize: 20),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: () => animationController!.reverse(),
                      child: Text('Reverse')),
                  ElevatedButton(
                      onPressed: () => animationController!.forward(),
                      child: Text('Forward'))
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
