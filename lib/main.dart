import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:words_app/models/word_type_adapter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  runApp(WordsApp());
}

class WordsApp extends StatelessWidget {
  const WordsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false);
  }
}
