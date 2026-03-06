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
      // 和AnimatedBuilder类似，每当 future 属性发生变化时叫一下builder重绘
      body: Center(
        child: FutureBuilder(
          future: Future.delayed(Duration(seconds: 2), () => throw ('oops')),
          initialData:
              72, // 在 future 没完成之前给 snapshot.data 赋予一个初始值，用了只需要判断 resolve 或 reject 状态即可，因为有初始值不存在 pending 可能
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return CircularProgressIndicator();
            // }
            // // 完成了，不管是resolve还是reject都走
            // if (snapshot.connectionState == ConnectionState.done) {
            //   return Text("${snapshot.data}");
            // }
            // throw 'should not happen';
            if (snapshot.hasError) {
              return Icon(Icons.error, size: 80);
            }
            if (snapshot.hasData) {
              return Text('${snapshot.data}', style: TextStyle(fontSize: 72));
            }
            // 换思路，不是 Resolve 也不是 Reject 肯定是 peding 状态
            return CircularProgressIndicator();
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
