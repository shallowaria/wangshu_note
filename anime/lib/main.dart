import 'dart:async';

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
  // final future = Future.delayed(Duration(seconds: 1), () => 42);
  // final stream = Stream.periodic(Duration(seconds: 1), (_) => 42);

  final controller = StreamController.broadcast();

  @override
  void initState() {
    super.initState();
    // stream 不加 broadcast 会记录操作，加了broadcast不会记录延时操作
    Future.delayed(Duration(seconds: 5), () {
      controller.stream.listen(
        (event) {
          print('event : $event');
        },
        onError: (err) => print('Error:$err'),
        onDone: () => print('DONE'),
      );
    });
  }

  @override
  void dispose() {
    controller.close();
    super.dispose();
  }

  // Stream 的 async 方法
  Future<int> getId() async {
    return 5;
  }

  // 每秒返回yield的值
  Stream<DateTime> getTime() async* {
    while (true) {
      await Future.delayed(Duration(seconds: 1));
      yield DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:
          // 类似于 FutureBuilder，每当 stream 发生改变时 builder 重新渲染一次
          Center(
            child: DefaultTextStyle(
              style:
                  Theme.of(context).textTheme.headlineLarge ??
                  TextStyle(fontSize: 24),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () => controller.sink.add(10),
                    child: Text('10'),
                  ),
                  ElevatedButton(
                    onPressed: () => controller.sink.add(1),
                    child: Text('1'),
                  ),
                  ElevatedButton(
                    onPressed: () => controller.sink.add('Hi'),
                    child: Text('Hi'),
                  ),
                  ElevatedButton(
                    onPressed: () => controller.sink.addError('oops'),
                    child: Text('Error'),
                  ),
                  ElevatedButton(
                    onPressed: () => controller.sink.close(),
                    child: Text('Close'),
                  ),
                  StreamBuilder(
                    stream: getTime(),
                    // stream: controller.stream
                    //     .map((event) => event * 2)
                    //     .where((event) => event is int)
                    //     .distinct(),
                    // 在 controller 状态下可以通过map和where和distinct进行变值和过滤和去重
                    // .map((event) => event * 2)
                    // .where((event) => event is int),
                    builder: (context, snapshot) {
                      print('building');
                      // 在 active 而非 done 时得到 error 或 data
                      switch (snapshot.connectionState) {
                        case ConnectionState.none:
                          return Text('NONE: 没有数据流');
                        case ConnectionState.waiting:
                          return Text('WATING: 等待数据流');
                        case ConnectionState.active:
                          if (snapshot.hasError) {
                            return Text('ACTIVE: 错误： ${snapshot.error}');
                          } else {
                            return Text('ACTIVE: 正常: ${snapshot.data}');
                          }
                        case ConnectionState.done:
                          return Text('DONE: 数据流已关闭');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
