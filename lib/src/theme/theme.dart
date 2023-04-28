
/*
 * AppTheme
 * Tema de la aplicacion 
*/

import 'package:flutter/material.dart';

class AppTheme{

  static ThemeData theme = ThemeData.light().copyWith(
    scaffoldBackgroundColor: const Color.fromRGBO(218, 228, 233, 1),
    appBarTheme: AppBarTheme(
      elevation: 0
    )
  );

}