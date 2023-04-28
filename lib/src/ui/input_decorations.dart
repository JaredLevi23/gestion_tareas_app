
/*
 * InputDecorations
 *  Decoradores para los textos de entrada 
 */

import 'package:flutter/material.dart';

class InputDecorations{

  static InputDecoration textFormFieldDecoration({ required String hintText }){
    return InputDecoration(
      hintText: hintText,
      hoverColor: Colors.white,
      focusColor: Colors.white,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular( 10 )
      )
    );
  }

}