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
  final _colors = [
    Colors.blue[100]!,
    Colors.blue[300]!,
    Colors.blue[500]!,
    Colors.blue[700]!,
    Colors.blue[900]!,
  ];

  late int _slot;

  // 打乱顺序
  void _shuffle() {
    setState(() {
      _colors.shuffle();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Listener(
        onPointerMove: (event) {
          final x = event.position.dx;

          print(x);
          if (x > (_slot + 1) * Box.width && _slot < _colors.length - 1) {
            setState(() {
              final c = _colors[_slot];
              _colors[_slot] = _colors[_slot + 1];
              _colors[_slot + 1] = c;
              _slot++;
            });
            // 减一会多跳一位
          } else if (x < _slot * Box.width && _slot > 0) {
            setState(() {
              final c = _colors[_slot];
              _colors[_slot] = _colors[_slot - 1];
              _colors[_slot - 1] = c;
              _slot--;
            });
          }
        },
        child: Stack(
          children: List.generate(_colors.length, (index) {
            return Box(
              color: _colors[index],
              x: index * Box.width,
              y: 200,
              onDrag: (Color color) {
                final index = _colors.indexOf(color);
                print('on drag $index');
                _slot = index;
              },
              key: ValueKey(_colors[index]),
            );
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _shuffle,
        tooltip: 'Random',
        child: Icon(Icons.replay),
      ),
    );
  }
}

class Box extends StatelessWidget {
  static const double width = 50.0;
  static const double height = 50.0;
  static const margin = 2.0;

  final Color color;
  final double x, y;
  final Function(Color) onDrag;

  const Box({
    super.key,
    required this.color,
    required this.x,
    required this.y,
    required this.onDrag,
  });

  @override
  Widget build(BuildContext context) {
    final container = Container(
      margin: EdgeInsets.all(8.0),
      width: width - 2 * margin,
      height: height - 2 * margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
    );

    return AnimatedPositioned(
      duration: Duration(milliseconds: 100),
      left: x,
      top: y,
      child: Draggable(
        onDragStarted: () => onDrag(color),
        feedback: container, // 跟鼠标走
        childWhenDragging: Visibility(
          visible: false,
          child: container,
        ), // 当child被拖动时渲染
        child: container,
      ),
    );
  }
}
