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
  double _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: 120,
          color: Colors.white,
          child: Row(
            children: [
              AnimatedCounter(duration: Duration(seconds: 1), value: _counter),
              AnimatedCounter(duration: Duration(seconds: 1), value: 8),
              AnimatedCounter(duration: Duration(seconds: 1), value: 6),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _counter += 1;
          });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AnimatedCounter extends StatelessWidget {
  final Duration duration;
  final double value;

  const AnimatedCounter({
    super.key,
    required this.value,
    required this.duration,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      height: 150,
      child: TweenAnimationBuilder(
        duration: duration,
        // tween: Tween(begin: 7.0, end: 8.0),
        tween: Tween<double>(begin: 0.0, end: value),
        builder: (context, value, child) {
          final whole = value ~/ 1; //取整除
          final decimal = value - whole; //取小数作为完成度

          return Stack(
            children: [
              Positioned(
                top: -100 * decimal, // 0 -> -100
                child: Opacity(
                  opacity: 1.0 - decimal, // 1.0 -> 0.0
                  child: Text('$whole', style: TextStyle(fontSize: 100)),
                ),
              ),
              Positioned(
                top: 100 - decimal * 100, // 100 -> 0
                child: Opacity(
                  opacity: decimal, // 0.0 -> 1.0
                  child: Text('${whole + 1}', style: TextStyle(fontSize: 100)),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
