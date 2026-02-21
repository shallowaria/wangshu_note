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
  bool _big = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: TweenAnimationBuilder(
          // 补帧动画
          duration: Duration(seconds: 1),
          tween: Tween<double>(
            begin: 72.0,
            end: _big ? 172 : 72,
          ), // between start~end，第一次启动后begin无意义，可以不传begin或传俩个相同的值
          builder: (context, value, child) {
            // value 是duration时间内 tween 从 begin - end 的值，按60帧来算，最后值为end的值，
            // 直接return child
            return Container(
              width: 300,
              height: 300,
              color: Colors.blue,
              child: Center(
                // 缩放scale+scale 旋转rotate+angle 平移translate+offset
                child: Text('Hi', style: TextStyle(fontSize: value)),
                // Transform.translate(
                // scale: value, double类型
                // angle: value, // 0-2Π
                // offset: value, //tween内可以放Offset属性
                // child: Text('Hi', style: TextStyle(fontSize: 72)),
                // ),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _big = !_big;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
