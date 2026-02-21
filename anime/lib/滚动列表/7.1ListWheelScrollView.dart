import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  // hash map: key value pair 键值对
  final String title;

  @override
  createState() => _MyHomePageState(); //删掉前面的类型声明，让Dart自动判断
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: RotatedBox(
        quarterTurns: 1,
        child: ListWheelScrollView(
          // offAxisFraction: -1.5, // 轴心偏移
          // diameterRatio: 0.8,
          overAndUnderCenterOpacity: 0.5,
          // magnification: 2.5,
          // useMagnifier: true, //无用
          physics: FixedExtentScrollPhysics(), //精确选择
          onSelectedItemChanged: (index) => print('selected $index'),
          itemExtent: 100,
          children: List.generate(10, (index) {
            return RotatedBox(
              quarterTurns: -1,
              child: Container(
                alignment: Alignment.center,
                child: Text('$index', style: TextStyle(fontSize: 72)),
              ),
            );
          }),
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
