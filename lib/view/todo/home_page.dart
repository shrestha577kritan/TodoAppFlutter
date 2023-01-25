import 'package:classapp/model/todo.dart';
import 'package:classapp/provider/todo_provider.dart';
import 'package:classapp/view/todo/update_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  final todoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Todo Application',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.w800),
        ),
        leading: IconButton(onPressed: (() {}), icon: Icon(Icons.menu)),
        actions: [
          IconButton(onPressed: (() {}), icon: Icon(Icons.search)),
        ],
      ),
      body: Consumer(builder: (context, ref, child) {
        final todoData = ref.watch(todoProvider);
        return SafeArea(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Column(
                children: [
                  TextFormField(
                    controller: todoController,
                    decoration: InputDecoration(
                      labelText: 'Add Your Work',
                      labelStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontWeight: FontWeight.w500),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                    ),
                    onFieldSubmitted: ((value) {
                      if (value.isEmpty) {
                        Get.defaultDialog(
                            title: 'Required',
                            content: Text('Add some list !'),
                            backgroundColor: Colors.grey,
                            buttonColor: Colors.amberAccent,
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    // Get.back();
                                    Navigator.of(context).pop();
                                  },
                                  child: Text('Close')),
                            ]);
                      } else {
                        final newTodo = Todo(
                          title: value,
                          id: DateTime.now().toString(),
                        );
                        ref.read(todoProvider.notifier).addTodo(newTodo);
                        todoController.clear();
                      }
                    }),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: todoData.length,
                        itemBuilder: (context, index) {
                          final todo = todoData[index];
                          return ListTile(
                            leading: Icon(Icons.work),
                            title: Text(todo.title),
                            subtitle: Text(todo.id.substring(0, 10)),
                            trailing: Container(
                              width: 100,
                              child: Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Get.to(() => UpdatePage(todo, index),
                                            transition: Transition.leftToRight);
                                      },
                                      icon: Icon(Icons.edit)),
                                  IconButton(
                                      onPressed: () {
                                        Get.defaultDialog(
                                            title: 'Hold on',
                                            content: Text(
                                                'Are you sure to delete !'),
                                            backgroundColor: Colors.grey,
                                            buttonColor: Colors.amberAccent,
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    // Get.back();
                                                    Navigator.of(context).pop();
                                                    ref
                                                        .read(todoProvider
                                                            .notifier)
                                                        .todoDelete(todo);
                                                  },
                                                  child: Text('Yes')),
                                              TextButton(
                                                  onPressed: () {
                                                    Get.back();
                                                  },
                                                  child: Text('No')),
                                            ]);
                                      },
                                      icon: Icon(Icons.delete)),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
