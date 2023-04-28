
/*
 * CustomButton
 * Boton personalizado reusable 
 */


import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {

  final String label;
  final Function()? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;

  const CustomButton({ Key? key, 
    required this.label, 
    this.onPressed, 
    this.backgroundColor, 
    this.foregroundColor 
  }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialButton(
      minWidth: double.maxFinite,
      height: 60,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular( 10 )
      ),
      color: backgroundColor ?? Colors.indigo,
      onPressed: onPressed,
      child: Text( 
        label, 
        style: TextStyle( 
          color: foregroundColor ?? Colors.white, 
          fontWeight: FontWeight.w300,
          fontSize: 20
        ), 
      ),
    );
  }
}