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
          height: 300,
          color: Colors.orange,
          child: AnimatedSwitcher(
            //只要Child属性更新就触发动画效果，但是同Widget不会变，除非加Key(UniqueKey),让Flutter意识到是不同的控件,给child传null会渐变消失
            // 会自动帮忙写如下代码,可嵌套
            transitionBuilder: (child, animation) {
              return FadeTransition(opacity: animation, child: child);
              // return RotationTransition(
              //   turns: animation,
              //   child: child,
              //   );
              // return ScaleTransition(
              // scale: animation,
              // child: child,
              // );
            },
            duration: Duration(seconds: 2),
            child: Text(
              'Hello',
              key: UniqueKey(),
              style: TextStyle(fontSize: 100),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
