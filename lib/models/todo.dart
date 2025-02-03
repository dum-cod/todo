class Todo {
  int? todoId;
  String content;
  bool completed;

  Todo({
    this.todoId,
    required this.content,
    required this.completed,
  });

  Map<String, dynamic> toMap() {
    return {
      'todoId': todoId,
      'content': content,
      'completed': completed ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      todoId: map['todoId'],
      content: map['content'],
      completed: map['completed'] == 1,
    );
  }
}
