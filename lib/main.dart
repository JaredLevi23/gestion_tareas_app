
/*
 * Main 
 * Inicia la app
 */

import 'package:flutter/material.dart';

import 'package:gestion_tareas_app/src/routes/routes.dart';
import 'package:gestion_tareas_app/src/services/task_service.dart';
import 'package:gestion_tareas_app/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp( 
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskService() )
      ],
      child: const GestionTareasApp(),
    ),
  );
}

class GestionTareasApp extends StatelessWidget {

const GestionTareasApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: 'home',
      routes: AppRoutes.routes,
      theme: AppTheme.theme,
    );
  }

}