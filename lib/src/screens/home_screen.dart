
/*
 *  HomeScreen 
 *  Pantalla de inicio, la primera que se muestra al iniciar la aplicacion
 */

import 'package:flutter/material.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),

      body: ListView.builder(
        itemCount: 10,
        itemBuilder: ( _, index ){
          return const TaskTile();
        }
      )
    );
  }
}

