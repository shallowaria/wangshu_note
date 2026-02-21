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
      home: MyHomePage(title: 'List View demo'),
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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            _controller.animateTo(
              -20.0,
              duration: Duration(seconds: 1),
              curve: Curves.easeIn,
            );
          },
          child: Text(widget.title),
        ),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: false
          ? Center(child: Text('Hooray, no spam here!'))
          : Scrollbar(
              child: ListView.builder(
                physics: BouncingScrollPhysics(), // 滚顶效果
                controller: _controller,
                padding: EdgeInsets.only(
                  bottom: 148,
                ), // ListView 自带padding，整个组件外padding
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Name'),
                    subtitle: Text('Subtitle'),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.delete_outline),
                    ),
                  );
                },
                // scrollDirection: Axis.horizontal, // 交叉轴永远占满
                itemCount: 200,
                itemExtent: 60, // 强制限制每个滚动列表的主轴方向为60
              ),
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _controller.animateTo(
            _controller.offset + 200,
            duration: Duration(seconds: 1),
            curve: Curves.ease,
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.arrow_downward),
      ),
    );
  }
}
