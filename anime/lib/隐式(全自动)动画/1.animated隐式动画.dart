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
  double _height = 200;

  void _firstAnime() {
    setState(() {
      _height += 100;
      if (_height > 500) _height = 200;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: AnimatedContainer(
          //隐式动画，以Animated开头，只需要duration属性，为所有除child的属性添加动画效果
          duration: Duration(milliseconds: 1000),
          width: 300,
          height: 300,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [Colors.red, Colors.white],
              stops: [0.2, 0.3],
            ),
            boxShadow: [BoxShadow(spreadRadius: 25, blurRadius: 25)],
            borderRadius: BorderRadius.circular(0),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _firstAnime,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
