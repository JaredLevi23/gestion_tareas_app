
/*
 * TaskTile
 * Widget que muestra la informacion basica de las tareas. 
 */

import 'package:flutter/material.dart';
import 'package:gestion_tareas_app/src/services/task_service.dart';
import 'package:provider/provider.dart';
import '../models/task_model.dart';

class TaskTile extends StatelessWidget {

  final TaskModel taskModel;
  final Function()? onPressed;
  const TaskTile({ Key? key, required this.taskModel, this.onPressed }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only( top: 8 ),
      child: MaterialButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular( 10 )
        ),
        color: Colors.white,
        padding: const EdgeInsets.symmetric( vertical: 10, horizontal: 10 ),
        minWidth: double.maxFinite,
        onPressed: onPressed,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
      
                Container(
                  padding: const EdgeInsets.all( 5 ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular( 15 ),
                    color: taskModel.isCompleted == 1 
                    ? Colors.green
                    : Colors.redAccent
                  ),
                  child: Text(
                    taskModel.isCompleted == 1 
                    ? 'Completada'
                    : 'Pendiente', 
                    style: const TextStyle( color: Colors.white ),
                  ),
                ),
              
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon( Icons.delete ) ,
                  onPressed: (){

                    showDialog(
                      context: context, builder: (_){
                        return AlertDialog(
                          title: const Text('¿Desea eliminar esta tarea?'),
                          content: Text( '${ taskModel.title }' ),
                          actions: [
                            
                            TextButton(
                              onPressed: () async {
                                final navigator = Navigator.of(context);
                                final taskService = Provider.of<TaskService>(context, listen: false);
                                await taskService.deleteTask(task: taskModel);
                                navigator.pop();
                              }, 
                              child: const Text('SI')
                            ),

                            TextButton(onPressed: () => Navigator.pop(context), child: const Text('NO'))
                          ],
                        );
                      }
                    );

                  }, 
                )
              ],
            ),
        
            Container(
              margin: const EdgeInsets.symmetric( horizontal: 5, vertical: 5 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
      
                  Text( 
                    taskModel.title ?? 'Sin titulo' , 
                    style: const TextStyle( fontSize: 22, fontWeight: FontWeight.w700 ),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  ),
            
                  const SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
      
            const Divider(),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(taskModel.dueDate ?? 'Sin fecha', style: const TextStyle( fontSize: 20, fontWeight: FontWeight.w400 ),),
              ],
            ),
        
        
          ],
        )
      ),
    );
  }
}