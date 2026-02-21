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
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.blue)),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 5),
      vsync: this,
    )..repeat(reverse: true); // 回传本身，级联操作符
    // 等价于 _controller.repeat(reverse: true);
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
        // child: ScaleTransition(
        //   scale: _controller.drive(Tween(begin: 0.5, end: 2.0)),
        //   child: Container(width: 300, height: 300, color: Colors.blue),
        // ),
        // 左右平移
        child: SlideTransition(
          // position: _controller.drive(
          //   Tween(begin: Offset(0, 0), end: Offset(0.1, 0)),
          // ), // 百分比
          // 等效写法，可以chain Tween
          position: Tween(begin: Offset(0, -0.5), end: Offset(0.0, 0.8))
              .chain(
                CurveTween(
                  // 把 [a, b] 这段时间映射到 0~1，其他时间固定 0 或 1
                  curve: Interval(0, 0.5), // 前 50% 时间 跑完动画
                  // Interval(0.8, 1.0) //80%时间什么都不做，剩下20%完成动画
                ),
              )
              .animate(_controller),
          child: Container(width: 300, height: 300, color: Colors.blue),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.stop();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

// 可以用 stan 快速构建一个动画组件
class Foo extends StatefulWidget {
  const Foo({super.key});

  @override
  State<Foo> createState() => _FooState();
}

class _FooState extends State<Foo> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
