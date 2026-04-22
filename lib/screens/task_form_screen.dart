import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task.dart';
import '../providers/task_provider.dart';
import '../widgets/task_item.dart';

class TaskFormScreen extends StatefulWidget {
  Task? task;

  TaskFormScreen({super.key, this.task});

  @override
  State<TaskFormScreen> createState() => _TaskFormScreenState();
}


class _TaskFormScreenState extends State<TaskFormScreen>{
  late TextEditingController _titleController;
  late TextEditingController _categoryController;
  final _formKey = GlobalKey<FormState>();
  bool _isEditing = false;

  @override
  void initState(){
    super.initState();

    if (widget.task!=null){
      _isEditing = true;
      _titleController = TextEditingController(text: widget.task!.title);
      _categoryController = TextEditingController(text:widget.task!.category);
    } else {
      _titleController = TextEditingController();
      _categoryController = TextEditingController();
    }
  }


  @override
  void dispose(){
    _titleController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  /*
  * VENTANA DE CONFIRMACION DE ELIMINACION DE TAREA
  */
  void showConfirmationDeleteDialog(BuildContext context, TaskProvider taskProvider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Eliminar tarea'),
          content: Text('¿Estás seguro de que deseas eliminar esta tarea de forma permanente?'),
          actions: [
            //boton de cancelar
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancelar'),
            ),
            //boton de confirmar
            TextButton(
              onPressed: () {
                taskProvider.deleteTask(widget.task!.id);
                //hay que cerrar las dos ventanas... la ventana emergente y el editor de la tarea
                Navigator.pop(context);
                Navigator.pop(context);
              },
              child: Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context){
    //final taskProvider = Provider.of<TaskProvider>(context, listen:false);
    final taskProvider = context.read<TaskProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Editar tarea': 'Añadir tarea',
        ), // text
      ), // appbar

      body: SafeArea(
        child: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Titulo',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'por favor ingrese un titulo';
                  }
                  return null;
                },
              ), // texformfield

              SizedBox(height: 20),

              TextFormField(
                controller: _categoryController,
                decoration: InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty){
                    return 'por favor ingrese una category';
                  }
                  return null;
                },
              ), // texformfield

              SizedBox(height: 20),

              Row(
                children: [
                ElevatedButton (
                  onPressed: (){
                    if (_formKey.currentState!.validate()){
                      _formKey.currentState!.save();
                      //editar tarea
                      if (_isEditing){
                        taskProvider.editTask(
                          widget.task!.id,
                          _titleController.text,
                          _categoryController.text
                        );
                      }
                      //agregar tarea
                      else {
                        taskProvider.addTask(
                          _titleController.text,
                          _categoryController.text
                        );
                      }
                      Navigator.pop(context);
                      //snack-bar despues de editar o crear
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            _isEditing ? 'Tarea actualizada' : 'Tarea creada',
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(_isEditing ? 'Guardar cambios': 'Añadir tarea' ),
                ), // elevatedbutton

                SizedBox(height: 50),

                if (_isEditing)
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      //showConfirmationDialog(context, taskProvider);
                      showConfirmationDeleteDialog(context, taskProvider);
                    },
                  ),
                ]
              )
            ],
          ), // column
        ), // form
      ), // padding
      ),
    ); // scaffold
  }

}
