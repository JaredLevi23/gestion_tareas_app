
/*
 * TaskTile
 * Widget que muestra la informacion basica de las tareas. 
 */

import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {
const TaskTile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context){
    return Card(
      child: Container(
        padding: const EdgeInsets.all( 5 ),
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
                    color: Colors.redAccent
                  ),
                  child: const Text('Pendiente', style: TextStyle( color: Colors.white ),),
                ),
              
                IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon( Icons.more_vert ) ,
                  onPressed: (){}, 
                )
              ],
            ),
    
            Container(
              margin: const EdgeInsets.symmetric( horizontal: 5, vertical: 5 ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text('Titulo ABCD', style: TextStyle( fontSize: 22, fontWeight: FontWeight.w700 ),),
            
                  SizedBox(
                    height: 8,
                  ),
                
                  Text(
                    'Do pariatur sunt duis eu id tempor pariatur dolor. Velit ad enim non in aliqua eiusmod occaecat voluptate. Dolor qui non et cillum nulla cillum quis ad. Amet sunt irure eu eu irure minim consequat esse esse eu. Incididunt eu tempor irure cillum anim ex. Anim culpa cupidatat consectetur ad incididunt mollit do ex amet est veniam qui.',
                    maxLines: 2,
                    style: TextStyle( fontSize: 17, fontWeight: FontWeight.w400 ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),

            const Divider(),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: const [
                    Icon( Icons.comment ),
                    SizedBox( width: 5, ),
                    Text('0', style: TextStyle( fontSize: 18 ),)
                  ],
                ),

                const Text('2023/04/26', style: TextStyle( fontSize: 19, fontWeight: FontWeight.w400 ),),
              ],
            ),
    
    
          ],
        ),
      ),
    );
  }
}