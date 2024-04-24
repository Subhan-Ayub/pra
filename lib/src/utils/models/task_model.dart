class Task {
  final int id;
  final String title;
  final bool completed;

  Task({required this.id, required this.title, required this.completed});

  factory Task.fromMap(Map<String, dynamic> map) => Task(
    id: map['id'],
    title: map['title'],
    completed: map['completed'] == 1,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'completed': completed ? 1 : 0,
  };
}