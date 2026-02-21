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

class _MyHomePageState extends State<MyHomePage> {
  double _top = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body:
          // 间距动画
          AnimatedPadding(
            padding: EdgeInsets.only(top: _top),
            duration: Duration(seconds: 2),
            curve: Curves.bounceOut, //动画开始和结束弹跳
            // https://api.flutter.dev/flutter/animation/Curves-class.html
            child: Container(width: 300, height: 300, color: Colors.blue),
          ),
      // 透明度动画
      // Center(
      //   child: AnimatedOpacity(
      //     duration: Duration(seconds: 2),
      //     curve: Curves.linear, //默认曲线 匀速变幻
      //     opacity: 0.8,
      //     child: Container(
      //       width: 300,
      //       height: 300,
      //       color: Colors.blue,
      //     ),
      //   ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _top += 100;
            if (_top > 300) _top = 0;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
