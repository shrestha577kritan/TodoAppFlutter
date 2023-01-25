import 'package:classapp/model/todo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// List<Todo> todos = [
//   Todo(title: 'workout', id: DateTime.now().toString()),
// ];

final todoProvider =
    StateNotifierProvider<TodoProvider, List<Todo>>((ref) => TodoProvider([]));

class TodoProvider extends StateNotifier<List<Todo>> {
  TodoProvider(super.state);

  void addTodo(Todo todo) {
    state.add(todo);
    state = [...state];
  }

  void todoDelete(Todo todo) {
    state = state.where((element) => element.id != todo.id).toList();
    // state.remove(todo);
    // state = [...state];
    // showDialog(context: context, builder: builder)
  }

  void TodoUpdate(Todo todo, int index) {
    state[index] = todo;
    state = [...state];
  }
}
