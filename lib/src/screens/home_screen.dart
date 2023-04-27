
/*
 *  HomeScreen 
 *  Pantalla de inicio, la primera que se muestra al iniciar la aplicacion
 */

import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),

      body: Center(
        child: Text('HomeScreen'),
      ),
    );
  }
}