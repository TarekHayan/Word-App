import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:words_app/controllers/cubit/read_data_cubit.dart';
import 'package:words_app/controllers/cubit/write_data_cubit_cubit.dart';
import 'package:words_app/models/hive_details.dart';
import 'package:words_app/models/word_type_adapter.dart';
import 'package:words_app/views/screens/home_screen.dart';
import 'package:words_app/views/styles/app_thems.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(WordTypeAdapter());
  Hive.openBox(HiveDetails.boxName);
  runApp(WordsApp());
}

class WordsApp extends StatelessWidget {
  const WordsApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => WriteDataCubitCubit()),
        BlocProvider(create: (context) => ReadDataCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppThems.appThems(),
        home: HomeScreen(),
      ),
    );
  }
}
