import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/controllers/cubit/write_data_cubit_cubit.dart';
import 'package:words_app/core/widgets/Loading_widget.dart';
import 'package:words_app/core/widgets/custom_snak_bar.dart';
import 'package:words_app/models/word_model.dart';

class WordDeatails extends StatelessWidget {
  const WordDeatails({super.key, required this.word});
  final WordModel word;
  @override
  Widget build(BuildContext context) {
    return BlocListener<WriteDataCubitCubit, WriteDataCubitState>(
      listener: (BuildContext context, WriteDataCubitState state) {
        if (state is WriteDataCubitSucess) {
          Navigator.pop(context);
          CustomSnackBar.show(
            context,
            message: "delete word  Sucess",
            type: SnackBarType.success,
          );
        } else if (state is WriteDataCubitfuliar) {
          CustomSnackBar.show(
            context,
            message: state.msgError,
            type: SnackBarType.error,
          );
        } else {
          Expanded(child: LoadingWidget());
        }
      },
      child: Scaffold(appBar: _customAppBar(context, word.indexInDataBase)),
    );
  }

  AppBar _customAppBar(BuildContext context, int index) {
    return AppBar(
      foregroundColor: Color(word.color),
      title: Text("Word Deatails", style: TextStyle(color: Color(word.color))),
      actions: [
        IconButton(
          onPressed: () async {
            BlocProvider.of<WriteDataCubitCubit>(context).deletWord(index);
          },
          icon: Icon(Icons.delete, color: Color(word.color)),
        ),
      ],
    );
  }
}
