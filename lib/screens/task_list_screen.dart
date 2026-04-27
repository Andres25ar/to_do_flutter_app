import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_list_app/routes/app_routes.dart';
import 'package:to_do_list_app/screens/task_form_screen.dart';
import '../providers/task_provider.dart';
import '../widgets/elevation_button.dart';
import '../widgets/task_item.dart';



class TaskListScreen extends StatelessWidget{
  TaskListScreen({super.key});

  @override
  Widget build(BuildContext context){
    final taskProvider = context.watch<TaskProvider>();
    final tasks = context.watch<TaskProvider>().tasks;
    final filter = context.watch<TaskProvider>().filter;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tareas (${tasks.length})'),
      ), //appbar

      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: !taskProvider.hasAnyTask ? Center(
              child: Text('No hay tareas', style: TextStyle(fontSize: 16),),
            )
            //si la lista de tareas creadas no está vacia
            :Row(
              children: [
                Expanded(
                  //Filtor "todas"
                  child: FilterButton(
                    label: 'Todas',
                    isSelected: filter == TaskFilter.all,
                    onPressed: () => context.read<TaskProvider>().setFilter(TaskFilter.all),
                  ),
                ), //expanded

                SizedBox(width: 10),

                //filtro "pendientes"
                Expanded(
                  child:  FilterButton(
                    label: 'Pendientes',
                    isSelected: filter == TaskFilter.pending,
                    onPressed: () => context.read<TaskProvider>().setFilter(TaskFilter.pending),
                  ),
                ), //expanded

                SizedBox(width: 10),

                //filtro "completados"
                Expanded(
                  child: FilterButton(
                    label: 'Completadas',
                    isSelected: filter == TaskFilter.completed,
                    onPressed: () => context.read<TaskProvider>().setFilter(TaskFilter.completed),
                  ),
                ), //expanded
              ], // children
            ), // row
          ), // padding

          Expanded (
            child: ListView.builder(
              itemCount: tasks.length,
              itemBuilder: (context, index) {
                final task = tasks[index];

                return TaskItem(task: task);
                /*return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context, MaterialPageRoute(
                        builder: (context) => TaskFormScreen(task: task,)
                    ));
                  },
                  child: TaskItem(task:task),
                );*/ // gestureDetector
              },
            ),
          ), // expanded
        ], // children
      ), // column

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, AppRoutes.addTask);
        },
        child: Icon(Icons.add),
      ), // floatingactionbutton

    );
  }
}
