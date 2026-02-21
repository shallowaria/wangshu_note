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
  final String title;

  @override
  createState() => _MyHomePageState(); //删掉前面的类型声明，让Dart自动判断
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late AnimationController _expansionController;
  late AnimationController _opacityController;

  @override
  void initState() {
    super.initState();
    _expansionController = AnimationController(
      vsync: this, // 刚开始建立的时候 vsync 不可访问，所以要在initS内赋值
      // duration: Duration(seconds: 20), 法1 1
    );
    _opacityController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _expansionController.dispose();
    _opacityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// ++++ 0000000 -------- 0
    /// 法1 交错动画 2
    // Animation animation1 = Tween(
    //   begin: 0.0,
    //   end: 1.0,
    // ).chain(CurveTween(curve: Interval(0.0, 0.2))).animate(_expansionController);

    // Animation animation3 = Tween(
    //   begin: 1.0,
    //   end: 0.0,
    // ).chain(CurveTween(curve: Interval(0.4, 0.95))).animate(_expansionController);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: FadeTransition(
          opacity: Tween(begin: 1.0, end: 0.5).animate(_opacityController),
          child: AnimatedBuilder(
            animation: _expansionController,
            builder: (context, child) {
              return Container(
                width: 300,
                height: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.blue,
                  gradient: RadialGradient(
                    colors: [Colors.blue[600]!, Colors.blue[100]!],
                    // 法2 在按钮处设置 duration
                    stops: [
                      _expansionController.value,
                      _expansionController.value + 0.1,
                    ],
                    // 法1 3
                    // _expansionController.value < 0.2
                    //     ? [
                    //         // 0.0, 1.0 // colors几个stops几个,第一个参数前纯浅蓝，两参间隔之间渐变
                    //         animation1.value, animation1.value + 0.1,
                    //       ]
                    //     : [animation3.value, animation3.value + 0.1],
                  ),
                ),
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _expansionController.duration = Duration(seconds: 4);
          _expansionController.forward();
          // sleep 4000
          await Future.delayed(Duration(seconds: 4));

          _opacityController.duration = Duration(milliseconds: 1750);
          _opacityController.repeat(reverse: true);
          await Future.delayed(Duration(seconds: 7));
          _opacityController.stop();

          _expansionController.duration = Duration(seconds: 8);
          _expansionController.reverse();
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
