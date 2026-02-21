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
  final String title;

  @override
  createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);
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
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SlidingBox(
              controller: _controller,
              color: Colors.blue[100]!, // 不require传[]的话要加断言
              interval: Interval(0.0, 0.2),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[300]!,
              interval: Interval(0.2, 0.4),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[500]!,
              interval: Interval(0.4, 0.6),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[700]!,
              interval: Interval(0.6, 0.8),
            ),
            SlidingBox(
              controller: _controller,
              color: Colors.blue[900]!,
              interval: Interval(0.8, 1.0),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class SlidingBox extends StatelessWidget {
  final AnimationController controller;
  final Color color;
  final Interval interval;

  const SlidingBox({
    super.key,
    required this.controller,
    this.color = Colors.blue,
    required this.interval,
  });

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: Tween(begin: Offset.zero, end: Offset(0.1, 0))
          .chain(CurveTween(curve: Curves.bounceOut))
          .chain(CurveTween(curve: interval))
          .animate(controller), // 复合函数 h(g(f(x))) 所有效果都有
      child: Container(width: 300, height: 100, color: color),
    );
  }
}
