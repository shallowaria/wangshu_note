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
  final _controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:
          // 进度条 顺序无关 冒泡接收的的进度
          Scrollbar(
            thumbVisibility: true, // 永远显示进度条，需要两者绑定同一个Controller
            controller: _controller,
            // 下拉刷新
            child: NotificationListener(
              onNotification: (notification) {
                print(notification);
                return true; // true 不继续冒泡， false 只看一眼
              },
              child: RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(Duration(seconds: 5));
                },
                strokeWidth: 4.0,
                color: Colors.red,
                backgroundColor: Colors.black,
                child: ListView.builder(
                  controller: _controller,
                  itemCount: 200,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.blue[(index % 9) * 100],
                      height: 50,
                    );
                  },
                ),
              ),
            ),
          ),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
