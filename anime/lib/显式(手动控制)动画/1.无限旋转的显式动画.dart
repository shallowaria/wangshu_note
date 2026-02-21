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
  bool _loading = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this, // 垂直同步：屏幕什么时候需要显示新的一帧
    );
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
        child: RotationTransition(
          turns: _controller, // 动画形式的Double，即用_controller代表value
          child: Icon(Icons.refresh, size: 100),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // _controller.forward(); // 向前一次
          // _controller.repeat(); // 重复
          // _controller.reset(); // 重置
          // _controller.stop(); // 原地停止
          if (_loading) {
            _controller.reset(); // loading 一开始为 false ，走 else
          } else {
            _controller.repeat();
          }
          _loading = !_loading;
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
