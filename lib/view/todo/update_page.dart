import 'package:classapp/provider/todo_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../../model/todo.dart';

class UpdatePage extends StatelessWidget {
  final Todo todo;
  final int index;

  UpdatePage(this.todo, this.index);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.all(15),
          child: Consumer(
            builder: ((context, ref, child) {
              return Container(
                child: TextFormField(
                  // controller: todoController,
                  initialValue: todo.title,
                  decoration: InputDecoration(
                    labelText: 'Edit Your Work',
                    labelStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 12,
                        fontWeight: FontWeight.w500),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10)),
                  ),
                  onFieldSubmitted: ((value) {
                    if (value.isEmpty) {
                      Get.defaultDialog(actions: [
                        TextButton(
                            onPressed: () {
                              // Get.back();
                              Navigator.of(context).pop();
                            },
                            child: Text('Close')),
                      ]);
                    } else {
                      final newTodo = Todo(title: value, id: todo.id);
                      ref
                          .read(todoProvider.notifier)
                          .TodoUpdate(newTodo, index);
                      Get.back();
                    }
                  }),
                ),
              );
            }),
          ),
        ),
      ),
    );
  }
}
