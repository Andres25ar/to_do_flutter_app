import 'package:flutter/material.dart';
import '../models/task.dart';
import '../providers/task_provider.dart';
import 'package:provider/provider.dart';

import '../screens/task_form_screen.dart';

class TaskItem extends StatelessWidget{
  final Task task;

  TaskItem({super.key, required this.task});

  @override
  Widget build(BuildContext context){
    final taskProvider = context.read<TaskProvider>();

    return Card(
      child: ListTile(
        onLongPress: () { //al mantener presionado un largo tiempo
          //alerta para condirmar la eliminacion de la tarea
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Eliminar tarea'),
              content: Text('¿Estás seguro de que deseas eliminar esta tarea de forma permanente?'),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),  //al presionar volver (se cancela)
                  child: Text('Cancelar'),
                ),
                TextButton(
                  onPressed: () {
                    context.read<TaskProvider>().deleteTask(task.id); //al presionar borra
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Tarea eliminada')),
                    );
                  },
                  child: Text('Eliminar', style: TextStyle(color: Colors.red)),
                ),
              ],
            ),
          );  //show dialog
        },
        onTap: () {
          Navigator.push(
              context, MaterialPageRoute(
              builder: (context) => TaskFormScreen(task: task,)
          ));
        },
        title: Text(
          task.title,
          style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough: null
          ), // textstyle
        ), // text

        trailing: Checkbox(
          value: task.isCompleted,
          onChanged: (value){
            taskProvider.toggleTaskStatus(task.id);
          },
        ), // checkbox

      ), // listtile
    );   // card
  }
}