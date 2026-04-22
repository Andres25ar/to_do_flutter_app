class Task {
  final String id;
  final String title;
  final String category;
  bool isCompleted;
  Task({
    required this.id,
    required this.title,
    required this.category,
    this.isCompleted = false,
  });
}