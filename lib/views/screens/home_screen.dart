import 'package:flutter/material.dart';
import 'package:words_app/views/widgets/color_note_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Home")),
      body: Column(children: [ColorNoteList()]),
    );
  }
}
