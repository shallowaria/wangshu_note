// 两种用法： 1.随意改变组件在 Widget Tree  中的位置，而状态不会丢失 2.通过key找到各种跟 Element 有关的数据
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
  // hash map: key value pair 键值对
  final String title;

  @override
  createState() => _MyHomePageState(); //删掉前面的类型声明，让Dart自动判断
}

class _MyHomePageState extends State<MyHomePage> {
  final _globalKey = GlobalKey(); // GlobalKey全局唯一
  final _globalKey1 = GlobalKey();
  final _globalKey2 = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Flex(
          direction: MediaQuery.of(context).orientation == Orientation.portrait
              ? Axis.vertical
              : Axis.horizontal,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Counter(),
            Counter(key: _globalKey),
          ],
        ),
        // 纯演示GlobalKey，做竖屏和横屏切换用 Flex
        // MediaQuery.of(context).orientation == Orientation.portrait
        //     ? Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Counter(key: _globalKey1),
        //           Center(child: Counter(key: _globalKey2)),
        //         ],
        //       )
        //     : Row(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           Counter(key: _globalKey1),
        //           Center(child: Counter(key: _globalKey2)),
        //         ],
        //       ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final state = _globalKey.currentState as _CounterState;

          state.setState(() {
            state._count++;
          });
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}

class Counter extends StatefulWidget {
  const Counter({super.key});

  @override
  State<Counter> createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          _count++;
        });
      },
      child: Text('$_count', style: TextStyle(fontSize: 72)),
    );
  }
}
