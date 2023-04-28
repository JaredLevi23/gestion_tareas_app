
import 'package:flutter/material.dart';
import 'package:gestion_tareas_app/src/services/task_service.dart';
import 'package:gestion_tareas_app/src/ui/input_decorations.dart';
import 'package:gestion_tareas_app/src/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){

    final taskService = Provider.of<TaskService>(context);
    final task = Provider.of<TaskService>(context).currentTask;

    return Scaffold(
      appBar: AppBar(
        title: Text( task.id != null ? 'Actualizar tarea' : 'Nueva tarea'),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric( horizontal: 10, vertical: 10 ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text('Toca para cambiar la fecha',
              style: TextStyle(
                fontSize: 15
              )
            ),
        
            GestureDetector(
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular( 10 ),
                  border: Border.all( width: 1, color: Colors.black54 ),
                  color: Colors.white       
                ),
                padding: const EdgeInsets.all(5),
                child: Center(
                  child: Text( task.dueDate ?? 'Sin fecha' , style: const TextStyle( fontSize: 22 ),),
                ),
              ),
              onTap: () async {

                final initialDate = task.dueDate != null ? DateTime( int.parse(task.dueDate!.split('-')[0]), int.parse(task.dueDate!.split('-')[1]), int.parse(task.dueDate!.split('-')[2]), ) : DateTime.now();

                final pickDate = await showDatePicker(
                  context: context, 
                  initialDate: initialDate,
                  firstDate: DateTime( 2020 ), 
                  lastDate: DateTime( 2030 )
                );

                if( pickDate != null ){
                  taskService.currentTask = taskService.currentTask..dueDate = pickDate.toString().split(' ')[0];
                }
              },
            ),
        
            const SizedBox(
              height: 10,
            ),

            const Text('Titulo',
              style: TextStyle(
                fontSize: 15
              )
            ),
        
            _BackgroundTextField(
              textField: TextFormField(
                initialValue: task.title ,
                decoration: InputDecorations.textFormFieldDecoration(hintText: 'Titulo'),
                onChanged: ( value ) => taskService.currentTask = taskService.currentTask..title = value,
              ),
            ),
        
            const SizedBox(
              height: 10,
            ),

            const Text('Descripción',
              style: TextStyle(
                fontSize: 15
              )
            ),
        
            _BackgroundTextField(
              textField: TextFormField(
                initialValue: task.description,
                decoration: InputDecorations.textFormFieldDecoration(hintText: 'Descripción'),
                maxLines: 5,
                onChanged: ( value ) => taskService.currentTask = taskService.currentTask..description = value,
              ),
            ),
        
            const SizedBox(
              height: 10,
            ),

            const Text('Comentarios',
              style: TextStyle(
                fontSize: 15
              )
            ),
        
            _BackgroundTextField(
              textField: TextFormField(
                initialValue: task.comments,
                decoration: InputDecorations.textFormFieldDecoration(hintText: 'Comentarios'),
                onChanged: ( value ) => taskService.currentTask = taskService.currentTask..comments = value,
                maxLines: 2,
              ),
            ),
        
            const SizedBox(
              height: 10,
            ),

            const Text('Tags',
              style: TextStyle(
                fontSize: 15
              )
            ),
        
            _BackgroundTextField(
              textField: TextFormField(
                initialValue: task.tags,
                decoration: InputDecorations.textFormFieldDecoration(hintText: 'Tags'),
                onChanged: ( value ) => taskService.currentTask = taskService.currentTask..tags = value,
              ),
            ),
        
            const SizedBox(
              height: 25,
            ),

            _BackgroundTextField(
              textField: Row(
                children: [

                  Checkbox(
                    value: task.isCompleted == 1, 
                    onChanged: ( value ){
                      taskService.currentTask = taskService.currentTask..isCompleted = value! ? 1 : 0;
                    }
                  ),

                  const SizedBox(
                    width: 10,
                  ),

                  const Text('Tarea completada', style: TextStyle( fontSize: 17 ),)

                ],
              )
            ),

            const SizedBox(
              height: 25,
            ),
        
            CustomButton(
              label: 'Guardar',
              onPressed: () async {
                final navigator = Navigator.of(context);
                await taskService.createOrUpdateTask(task: taskService.currentTask );
                navigator.pop();
              },
            )
        
          ],
        ),
      )
    );
  }
}


class _BackgroundTextField extends StatelessWidget {

  final Widget textField;

const _BackgroundTextField({ Key? key, required this.textField }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular( 10 )
      ),
      child: textField,
    );
  }
}