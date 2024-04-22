import 'package:flutter/material.dart';
import 'package:todolist/models/todo.dart';
import 'package:todolist/screens/add_todo.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Box todoBox = Hive.box<Todo>('todo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        centerTitle: true,
        title: const Text(
          'Hive Todo',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ValueListenableBuilder(
        valueListenable: todoBox.listenable(),
        // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
        builder: (context, Box box, Widget) {
          if (box.isEmpty) {
            return const Center(
              child: Text('No Todo available'),
            );
          } else {
            return ListView.builder(
              reverse: true,
              shrinkWrap: true,
              itemCount: box.length,
              itemBuilder: (context, index) {
                Todo todo = box.getAt(index);
                return ListTile(
                  tileColor: const Color.fromARGB(255, 230, 222, 186),
                  title: Text(
                    todo.title,
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: todo.iscompleted ? Colors.green : Colors.black,
                        decoration: todo.iscompleted
                            ? TextDecoration.lineThrough
                            : TextDecoration.none),
                  ),
                  leading: Checkbox(
                    value: todo.iscompleted,
                    onChanged: (value) {
                      Todo newTodo =
                          Todo(title: todo.title, iscompleted: value!);
                      box.putAt(index, newTodo);
                    },
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      box.deleteAt(index);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Todo Deleted Successfully"),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.amber,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTodo(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
