import 'dart:ui';

import 'package:bosc_machine_test/main.dart';
import 'package:bosc_machine_test/view/delete.dart';
import 'package:bosc_machine_test/view/update.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:bosc_machine_test/model/notes_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: const Text(
          'Notes App',
          style: TextStyle(
              color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: ValueListenableBuilder(
          valueListenable: notesBoxVariable.listenable(),
          builder:
              (BuildContext context, Box<NotesModel> noteItems, Widget? _) {
            List<int> keys = notesBoxVariable.keys.cast<int>().toList();
            return notesBoxVariable.isEmpty
                ? const Center(
                    child: Text(
                      'No Item Found !',
                      style: TextStyle(
                          color: Colors.grey,
                          fontSize: 30,
                          fontWeight: FontWeight.w800),
                      textAlign: TextAlign.center,
                    ),
                  )
                : ListView.builder(
                    itemCount: noteItems.length,
                    itemBuilder: (context, index) {
                      int key = keys[index];
                      NotesModel? notes = notesBoxVariable.get(key);

                      return Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    notes!.title,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                Update(updateKey: key),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Colors.deepPurpleAccent,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () =>
                                            Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) => Delete(deleteKey: key,),
                                          ),
                                        ),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.redAccent,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Text(
                                notes.description,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.blueGrey),
                                textAlign: TextAlign.start,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          size: 35,
        ),
        onPressed: () => showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(25),
            ),
          ),
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: EdgeInsets.only(
                  left: 15,
                  right: 15,
                  top: 25,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                  const SizedBox(
                    height: 30,
                  ),
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
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      NotesModel addNote = NotesModel(
                          description: descriptionController.text,
                          title: titleController.text);
                      if (titleController.text.isEmpty ||
                          descriptionController.text.isEmpty) {
                        return;
                      } else {
                        notesBoxVariable.add(addNote);
                      }

                      Navigator.pop(context);
                      titleController.clear();
                      descriptionController.clear();
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                    style: ElevatedButton.styleFrom(primary: Colors.deepPurple),
                  ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
