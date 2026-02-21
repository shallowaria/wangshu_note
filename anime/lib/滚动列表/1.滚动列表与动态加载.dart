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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      // ListView 接收children ListView.separated 在builder的基础上加分割线，有自己的separatorBuilder属性,其他和ListView.builder相同
      body: ListView.separated(
        separatorBuilder: (context, index) {
          if (index == 0) {
            return Divider(thickness: 4, color: Colors.red);
          }
          return Divider();
        },
        cacheExtent: 2000, // 预缓冲,默认1/3左右屏幕
        itemCount: 88, // 不写默认无限，按需加载
        itemBuilder: (context, index) {
          return Container(
            height: 100,
            color: Colors.blue[(index % 5) * 100],
            alignment: Alignment.center,
            child: Text('$index'),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
