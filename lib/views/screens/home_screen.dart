import 'package:flutter/material.dart';
import 'package:words_app/views/widgets/custom_dialog.dart';
import 'package:words_app/views/widgets/custom_icon_button.dart';
import 'package:words_app/views/widgets/words_language_filter.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: _CutomFloatingActionButton(),
      appBar: AppBar(title: Text("Home")),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [WordsLanguageFilter(), CustomFiltersIconButton()],
            ),
          ],
        ),
      ),
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
