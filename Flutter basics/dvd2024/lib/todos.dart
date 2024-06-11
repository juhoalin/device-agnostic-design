import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Todo {
  final String item;

  Todo({required this.item});
}

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);

  addTask(Todo todo) {
    state = [todo, ...state];
  }
}

final todoProvider =
    StateNotifierProvider<TodoNotifier, List<Todo>>((ref) => TodoNotifier());

class TodoForm extends ConsumerStatefulWidget {
  @override
  ConsumerState<TodoForm> createState() => _TodoFormState();
}

class _TodoFormState extends ConsumerState<TodoForm> {
  final _todoNameController = TextEditingController();

  _addTodo() {
    ref
        .watch(todoProvider.notifier)
        .addTask(Todo(item: _todoNameController.text));
    _todoNameController.clear();
  }

  @override
  void dispose() {
    _todoNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextField(
        controller: _todoNameController,
        decoration: const InputDecoration(
            hintText: 'Todo name', border: OutlineInputBorder()),
      ),
      ElevatedButton(onPressed: _addTodo, child: const Text('Add todo')),
    ]);
  }
}

class TodoList extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
        children:
            ref.watch(todoProvider).map((t) => Text('${t.item}')).toList());
  }
}

void main() {
  runApp(ProviderScope(child: TaskApp()));
}

class TaskApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(body: Column(children: [TodoForm(), TodoList()])));
  }
}
