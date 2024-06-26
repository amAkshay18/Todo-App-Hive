import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todolist/models/todo.dart';

// ignore: must_be_immutable
class AddTodo extends StatelessWidget {
  AddTodo({super.key});
  TextEditingController titleController = TextEditingController();
  Box todoBox = Hive.box<Todo>('todo');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Title",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (titleController.text != '') {
                    Todo newTodo =
                        Todo(title: titleController.text, iscompleted: false);
                    todoBox.add(newTodo);
                    Navigator.pop(context);
                  }
                },
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.amber),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)))),
                child: const Text(
                  "Add Todo",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
