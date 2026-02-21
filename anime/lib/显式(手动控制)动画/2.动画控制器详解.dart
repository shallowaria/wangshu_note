import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Flutter Anime'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      // 动画开始时会从lowerBound 的 value(3.0) 通过 duration seconds(1s) 到 upperBound value(5.0)
      duration: Duration(seconds: 1),
      // lowerBound: 3.0, // 下限
      // upperBound: 5.0, // 上限
      lowerBound: 0,
      upperBound: 1,
      vsync: this,
    );
    _controller.addListener(() {
      // print('${_controller.value}');
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child:
            // RotationTransition(
            //   turns: _controller, // 3~5
            //   child: Container(width: 300, height: 300, color: Colors.blue),
            // ),
            // FadeTransition(
            //   opacity: _controller, // 3~5
            //   child: Container(width: 300, height: 300, color: Colors.blue),
            // ),
            ScaleTransition(
              scale: _controller, // 3~5
              child: Container(width: 300, height: 300, color: Colors.blue),
            ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _controller.forward(from: 0);
          _controller.repeat(
            reverse: true,
          ); // 从 lowerCase0~upperCase1 再 从 UpperCase1 ~ lowerCase0
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
