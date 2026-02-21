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
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: 200,
        itemBuilder: (_, index) {
          return Dismissible(
            key: UniqueKey(),
            background: Container(
              color: Colors.green,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 24.0),
              child: Icon(Icons.phone, size: 24), // Icon 默认 24
            ), //阅读方向
            secondaryBackground: Container(
              color: Colors.black,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(right: 24.0),
              child: Icon(Icons.sms, color: Colors.white),
            ), //反阅读方向
            onDismissed: (direction) {
              print(direction); // startToEnd
              if (direction == DismissDirection.startToEnd) {
                print('phone');
              }
            },
            // 删除时一直触发
            onResize: () {
              print('on resizing');
            },
            dismissThresholds: {
              DismissDirection.startToEnd: 0.1,
              DismissDirection.endToStart: 0.99,
            },
            resizeDuration: Duration(seconds: 5),
            movementDuration: Duration(seconds: 5), // 帮用户操作的时间
            // 确定删除
            // confirmDismiss: (direction) async {
            //   await Future.delayed(Duration(seconds: 2));
            //   return false;
            // },
            child: Container(height: 72, color: Colors.blue[(index % 9) * 100]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
