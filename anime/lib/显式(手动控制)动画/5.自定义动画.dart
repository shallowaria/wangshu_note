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
  createState() => _MyHomePageState(); //删掉前面的类型声明，让Dart自动判断
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Animation opacityAnimation = Tween(
      begin: 0.5,
      end: 0.8,
    ).animate(_controller); // 法1实现tween

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: AnimatedBuilder(
          animation: _controller, // animation作用：监听控制器，每当有变化时叫builder重跑函数
          builder: (context, child) {
            return Opacity(
              opacity: opacityAnimation.value,
              child: Container(
                width: 300,
                height: Tween(
                  begin: 100.0,
                  end: 200.0,
                ).evaluate(_controller), // 法2实现tween
                color: Colors.blue,
                child: child, // 这里传外面的child，也在AnimatedBuilder内
              ),
            );
          },
          // 传给 build 的child ，避免重绘
          child: Center(child: Text('Hi', style: TextStyle(fontSize: 72))),
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
