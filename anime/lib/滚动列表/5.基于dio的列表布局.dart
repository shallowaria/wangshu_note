import 'package:anime/%E6%BB%9A%E5%8A%A8%E5%88%97%E8%A1%A8/github_event.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

final dio = Dio();

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
  // 1. 定义一个成员变量，用来存储数据
  List<GithubEvent> _events = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      // 3. 根据 _events 是否为空来显示不同的内容
      body: Scrollbar(
        child: RefreshIndicator(
          onRefresh: () async {
            await _refresh();
          },
          child: ListView.builder(
            itemCount: _events.length,
            itemBuilder: (context, index) {
              final event = _events[index];
              return Dismissible(
                confirmDismiss: (direction) async {
                  return showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text('Are you sure?'),
                        content: Text('Do you want to delete this item?'),
                        actions: [
                          ElevatedButton.icon(
                            icon: Icon(Icons.share_arrival_time),
                            onPressed: () {
                              Navigator.of(context).pop(false);
                            },
                            label: Text('Cancel'),
                          ),
                          ElevatedButton.icon(
                            icon: Icon(Icons.share_arrival_time),
                            onPressed: () {
                              Navigator.of(context).pop(true);
                            },
                            label: Text(
                              'Delete',
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
                onDismissed: (direction) {
                  setState(() {
                    _events.removeWhere((e) => e.id == event.id);
                  });
                },
                key: ValueKey(event.id),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(event.actor.avatarUrl),
                  ),
                  title: Text(event.actor.login),
                  subtitle: Text('User: ${event.repo.name}'),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Future<void> _refresh() async {
    final res = await dio.get('https://api.github.com/events');
    if (res.statusCode == 200) {
      final List<dynamic> rawData = res.data;

      // 2. 将解析好的数据通过 setState 赋值给成员变量
      setState(() {
        _events.clear();
        _events = rawData.map((item) => GithubEvent.fromJson(item)).toList();
      });
    }
  }
}
