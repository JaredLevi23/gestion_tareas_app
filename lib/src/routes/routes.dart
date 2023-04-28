
/*
 * AppRoutes
 * Rutas de la aplicacion 
*/

import 'package:flutter/material.dart';
import 'package:gestion_tareas_app/src/screens/screens.dart';

class AppRoutes{

  static Map<String, Widget Function(BuildContext)> routes = {
    'home': (_) => const HomeScreen(),
    'create': (_) => const CreateTaskScreen(),
  };

}