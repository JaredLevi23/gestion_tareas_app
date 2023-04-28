
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:gestion_tareas_app/src/models/task_model.dart';
import 'package:http/http.dart' as http;

class TaskService extends ChangeNotifier{

  final _baseUrl = 'https://ecsdevapi.nextline.mx/vdev/tasks-challenge/tasks';
  final _token = 'e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd';

  bool _isLoading = false;

  List<TaskModel> tasks = [];
  List<TaskModel> get imcompleteTasks => tasks.where((element) => element.isCompleted != 1 ).toList();
  List<TaskModel> get completeTasks => tasks.where((element) => element.isCompleted == 1 ).toList();

  late TaskModel _currentTask;

  TaskModel get currentTask => _currentTask;

  set currentTask(TaskModel value) {
    _currentTask = value;
    notifyListeners();
  }

  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  TaskService();

  /// Obtener todas las tareas
  Future<void> getTasks () async {

    try {
      isLoading = true;

      final headers = {
        'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd'
      };

      final tasksResponse = await http.get(
        Uri.parse( '$_baseUrl?token=$_token' ),
        headers: headers
      );

      if( tasksResponse.statusCode == 200 ){
        log( tasksResponse.body );
        final List decodeResponse = json.decode( tasksResponse.body );
        tasks = decodeResponse.map((e) => TaskModel.fromJson( e )).toList();
        notifyListeners();
      }
    } catch (e) {
      log('error( getTask ): $e');
    }finally{
      isLoading = false;
    }
  }

  /// Obtener una tarea por id
  Future<TaskModel?> getTaskById({ required int id }) async {

    try {
      isLoading = true;

      final headers = {
        'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd'
      };
      
      final taskResponse = await http.get(
        Uri.parse( '$_baseUrl/$id?token=$_token' ),
        headers: headers
      );

      if( taskResponse.statusCode == 200 ){
        final List taskDecode = json.decode( taskResponse.body );
        return TaskModel.fromJson( taskDecode[0] );
      }
      return null;
    } on Exception catch (e) {
      log( 'error( getTaskById ): $e' );
      return null;
    }finally{
      isLoading = false;
    }
  }

  /// Crear o actualizar una tarea
  Future<void> createOrUpdateTask( { required TaskModel task } ) async{
    if( task.id == null ){
      createTask(task: task);
    }else{
      updateTask(task: task);
    }
  }

  /// Crear una tarea
  Future<void> createTask({ required TaskModel task }) async {
    try {
      isLoading = true;

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd'
      };
      
      final taskResponse = await http.post(
        Uri.parse(_baseUrl),
        headers: headers,
        body: task.toJson(_token),
        encoding: Encoding.getByName('utf-8'),
      );
      
      if( taskResponse.statusCode == 201 ){
       await getTasks();
      }
    } on Exception catch (e) {
      log( 'error( createTask ): $e' );
    }finally{
      isLoading = false;
    }
  }

  /// Actualizar una tarea
  Future<void> updateTask({ required TaskModel task }) async{
     try {

      isLoading = true;

      final headers = {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd'
      };
      
      final taskResponse = await http.put(
        Uri.parse('$_baseUrl/${ task.id }'),
        headers: headers,
        body: task.toJson(_token),
        encoding: Encoding.getByName('utf-8'),
      );
      
      if( taskResponse.statusCode == 201 ){
       await getTasks();
      }

    } on Exception catch (e) {
      log( 'error( createTask ): $e' );
    }finally{
      isLoading = false;
    }
  }

  /// Eliminar una tarea
  Future<void> deleteTask({ required TaskModel task }) async{
    try {
      isLoading = true;

      final headers = {
        'Authorization': 'Bearer e864a0c9eda63181d7d65bc73e61e3dc6b74ef9b82f7049f1fc7d9fc8f29706025bd271d1ee1822b15d654a84e1a0997b973a46f923cc9977b3fcbb064179ecd'
      };
      
      final taskResponse = await http.delete(
        Uri.parse('$_baseUrl/${ task.id }?token=$_token'),
        headers: headers
      );
      
      if( taskResponse.statusCode == 201 ){
        getTasks();
      }

    } on Exception catch (e) {
      log( 'error( createTask ): $e' );
    }finally{
      isLoading = false;
    }
  }

}
