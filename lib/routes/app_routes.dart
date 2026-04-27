import 'package:flutter/material.dart';
import '../screens/task_form_screen.dart';
import '../screens/task_list_screen.dart';

//configuracion de rutas
class AppRoutes {
  static const String home = '/';
  static const String addTask = '/add-task';

  static Map<String, WidgetBuilder> routes = {
    home: (context) => TaskListScreen(),
    addTask: (context) => TaskFormScreen(),
  };
}
