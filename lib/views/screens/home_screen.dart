import 'package:flutter/material.dart';
import 'package:words_app/views/widgets/custom_dialog.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _CutomFloatingActionButton(),
      appBar: AppBar(title: Text("Home")),
      //body: Column(children: [ColorNoteList()]),
    );
  }
}

class _CutomFloatingActionButton extends StatelessWidget {
  const _CutomFloatingActionButton();

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showDialog(context: context, builder: (context) => CustomDialog());
      },
      shape: CircleBorder(),
      child: Icon(Icons.add),
    );
  }
}
