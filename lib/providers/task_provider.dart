import 'package:flutter/material.dart';
import '../models/task.dart';

enum TaskFilter{
  all,
  completed,
  pending
}

class TaskProvider extends ChangeNotifier{
  final List<Task> _tasks = [];
  TaskFilter _filter = TaskFilter.all;

  List<Task> get tasks {
    switch (_filter){
      case TaskFilter.completed:
        return _tasks.where((task) => task.isCompleted).toList();

      case TaskFilter.pending:
        return _tasks.where((task) => !task.isCompleted).toList();

      default:
        return _tasks;
    }
  }

  TaskFilter get filter => _filter;

  void setFilter(TaskFilter filter){
    _filter = filter;
    notifyListeners();
  }

  void addTask(String title, String category){
    final newTask = Task(id: DateTime.now().toString(), title: title, category: category);
    _tasks.add(newTask);
    notifyListeners();
  }

  void toggleTaskStatus(String id){
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex!=-1){
      _tasks[taskIndex].isCompleted = !_tasks[taskIndex].isCompleted;
      notifyListeners();
    }
  }

  void editTask(String id, String newTitle, String newCategory){
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex!=-1) {
      _tasks[taskIndex] = Task(
          id : id,
          title: newTitle,
          category: newCategory,
          isCompleted : _tasks[taskIndex].isCompleted);

      notifyListeners();
    }
  }

  void deleteTask (String id){
    _tasks.removeWhere((task) => task.id == id);
    notifyListeners();
  }

  bool get hasAnyTask => _tasks.isNotEmpty;
}