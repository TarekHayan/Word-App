import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/controllers/cubit/read_data_cubit.dart';
import 'package:words_app/core/widgets/Loading_widget.dart';
import 'package:words_app/core/widgets/empty_data_widget.dart';
import 'package:words_app/core/widgets/something_error_widget.dart';
import 'package:words_app/models/word_model.dart';
import 'package:words_app/views/styles/app_colors.dart';
import 'package:words_app/views/widgets/word_deatails.dart';

class WordsWidget extends StatelessWidget {
  const WordsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        if (state is ReadDataSucess) {
          if (state.words.isEmpty) {
            return Expanded(child: EmptyDataWidget());
          }
          return _itemsWordList(state.words, context);
        } else if (state is ReadDatafauliar) {
          return SomethingError(
            message: state.error,
            onRetry: () {
              BlocProvider.of<ReadDataCubit>(context).getWords();
            },
          );
        } else {
          return Center(child: LoadingWidget());
        }
      },
    );
  }

  Widget _itemsWordList(List<WordModel> words, BuildContext context) {
    return Expanded(
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 5,
          crossAxisSpacing: 5,
          crossAxisCount: 2,
        ),
        itemCount: words.length,
        itemBuilder: (context, index) {
          return _itemWord(words[index], context);
        },
      ),
    );
  }

  Widget _itemWord(WordModel word, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return WordDeatails(word: word);
            },
          ),
        ).then((value) {
          BlocProvider.of<ReadDataCubit>(context).getWords();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          color: Color(word.color),
          borderRadius: BorderRadius.circular(24),
        ),
        child: Center(
          child: Text(
            word.word,
            style: TextStyle(
              fontSize: 24,
              color: AppColors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
