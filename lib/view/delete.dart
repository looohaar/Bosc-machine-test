import 'dart:ui';

import 'package:bosc_machine_test/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Delete extends StatelessWidget {
  final int deleteKey;
  Delete({required this.deleteKey});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      
      title: const Text(
        'Delete Note',
        style: TextStyle(
          color: Colors.deepPurple,
          fontSize: 25,
        ),
        textAlign: TextAlign.center,
      ),
      content: const Text(
        'Are You Sure You Want To Delete ?',
        style: TextStyle(color: Colors.black, fontSize: 20),
      ),
      actions: [
        TextButton(
          onPressed: () {
            notesBoxVariable.delete(deleteKey);
            Navigator.pop(context);
          },
          child: const Text(
            'Yes',
            style: TextStyle(color: Colors.deepPurple, fontSize: 18),
          ),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text(
            'No',
            style: TextStyle(color: Colors.deepPurple, fontSize: 18),
          ),
        )
      ],
    );
  }
}
