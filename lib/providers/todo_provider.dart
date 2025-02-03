import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/todo.dart';
import '../services/database_helper.dart';

final todoProvider = StateNotifierProvider<TodoListNotifier, List<Todo>>((ref) {
  return TodoListNotifier();
});

class TodoListNotifier extends StateNotifier<List<Todo>> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  TodoListNotifier() : super([]) {
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await _dbHelper.getAllTodos();
    state = todos;
  }

  Future<void> addTodo(String content) async {
    final newTodo = Todo(
      content: content,
      completed: false,
    );
    await _dbHelper.insertTodo(newTodo);
    await _loadTodos();
  }

  Future<void> completeTodo(int id) async {
    final todo = state.firstWhere((t) => t.todoId == id);
    final updatedTodo = Todo(
      todoId: todo.todoId,
      content: todo.content,
      completed: !todo.completed,
    );
    await _dbHelper.updateTodo(updatedTodo);
    await _loadTodos();
  }

  Future<void> deleteTodo(int id) async {
    await _dbHelper.deleteTodo(id);
    await _loadTodos();
  }
}
