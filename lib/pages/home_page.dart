import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:siri_ai/types/tasks_tile.dart';
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final List<TasksTile> tasks = <TasksTile>[
    TasksTile("Linear Regression", "/linear"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        title: Text("Select Task"),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: ListView.builder(itemCount: tasks.length ,itemBuilder: (BuildContext context, int index){
        return ListTile(
          title: Text(tasks[index].label),
          onTap: () {
            context.go(tasks[index].path);
          },
        );
      },),
    );
  }
}
