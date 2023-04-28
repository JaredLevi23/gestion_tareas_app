
/*
 *  HomeScreen 
 *  Pantalla de inicio, la primera que se muestra al iniciar la aplicacion
 */

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:gestion_tareas_app/src/models/task_model.dart';
import 'package:gestion_tareas_app/src/services/task_service.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({ Key? key }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    final taskService = Provider.of<TaskService>(context, listen: false);
    
    SchedulerBinding.instance.addPostFrameCallback((_) {
      taskService.getTasks();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context){

    final taskService = Provider.of<TaskService>(context);

    return SafeArea(
      child: Scaffold(
    
        body: taskService.isLoading 
        ? const Center( child: CircularProgressIndicator() )
        : SingleChildScrollView(
          padding: const EdgeInsets.symmetric( horizontal: 5, vertical: 10 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              const SizedBox(
                height: 20,
              ),

              const Text('Por terminar...',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                )
              ),

              ...taskService.imcompleteTasks.map(( task ) => TaskTile(
                taskModel: task,
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  taskService.currentTask = await taskService.getTaskById( id:  task.id! ) ?? task;
                  navigator.pushNamed('create');
                },
               )).toList(),

              const SizedBox(
                height: 20,
              ),

              const Text('Completadas',
                style: TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
                )
              ),

              ...taskService.completeTasks.map(( task ) => TaskTile(
                taskModel: task,
                onPressed: () async {
                  final navigator = Navigator.of(context);
                  taskService.currentTask = await taskService.getTaskById( id:  task.id! ) ?? task;
                  navigator.pushNamed('create');
                }
              )).toList(),

            ],
          ),
        ),
    
        floatingActionButton: FloatingActionButton(
          child: const Icon( Icons.add ),
          onPressed: (){
            taskService.currentTask = TaskModel(
              dueDate: DateTime.now().toString().split(' ')[0],
              title: '',
              description: '',
              comments: '',
              tags: '',
              isCompleted: 0
            );
            Navigator.pushNamed(context, 'create');
          }
        ),
      ),
    );
  }
}

