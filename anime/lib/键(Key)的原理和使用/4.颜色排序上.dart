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
  final boxes = [
    Box(color: Colors.blue[100]!, key: UniqueKey()),
    Box(color: Colors.blue[300]!, key: UniqueKey()),
    Box(color: Colors.blue[500]!, key: UniqueKey()),
    Box(color: Colors.blue[700]!, key: UniqueKey()),
    Box(color: Colors.blue[900]!, key: UniqueKey()),
  ];

  // 打乱顺序
  void _shuffle() {
    setState(() {
      boxes.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(child: Row(children: boxes)),
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffle,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Box extends StatelessWidget {
  final Color color;

  const Box({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: Container(
        // 跟鼠标走
        margin: EdgeInsets.all(8.0),
        width: 50,
        height: 50,
        color: color,
      ),
      childWhenDragging: Container(
        // 当child被拖动时渲染
        margin: EdgeInsets.all(8.0),
        width: 50,
        height: 50,
      ),
      child: Container(
        margin: EdgeInsets.all(8.0),
        width: 50,
        height: 50,
        color: color,
      ),
    );
  }
}
