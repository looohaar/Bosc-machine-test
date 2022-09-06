
import 'dart:ui';

import 'package:bosc_machine_test/main.dart';
import 'package:bosc_machine_test/model/notes_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Update extends StatelessWidget {
 final int updateKey;
 Update({required this.updateKey});

  @override
  Widget build(BuildContext context) {
    final titleController= TextEditingController();
    final descriptionController= TextEditingController();

    titleController.text= notesBoxVariable.get(updateKey)!.title;
    descriptionController.text=notesBoxVariable.get(updateKey)!.description;

    return Scaffold(
      appBar: AppBar(
        title:const  Text(
          'Update',
          style: TextStyle(
            color: Colors.white,
             fontSize: 25,
             fontWeight: FontWeight.bold),
        ),
         centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
             TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          hintText: 'Title',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 192, 171, 250)),
                    ),
                    const SizedBox(height: 30,),
              TextField(
                
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          hintText: 'Description',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(50),
                            ),
                          ),
                          filled: true,
                          fillColor: Color.fromARGB(255, 192, 171, 250)),
                    ),
                     const SizedBox(height: 30,),
              ElevatedButton(onPressed: (){
              
              NotesModel updateItem= NotesModel(description: descriptionController.text,
               title: titleController.text);
          
                notesBoxVariable.put(updateKey, updateItem);
                Navigator.pop(context);
              },
               child:  Text('Update',
               style: TextStyle(
                color: Colors.white,
                fontSize: 25
               ),),
                 style: ElevatedButton.styleFrom(primary: Colors.deepPurple),)

            ],
          ),
        ),
      ),
    );
  }
}
