import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/controllers/cubit/read_data_cubit.dart';
import 'package:words_app/views/styles/app_colors.dart';

class WordsLanguageFilter extends StatelessWidget {
  const WordsLanguageFilter({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Text(
          _convertLanguageFilterToString(
            BlocProvider.of<ReadDataCubit>(context).languageFilter,
          ),
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        );
      },
    );
  }

  String _convertLanguageFilterToString(LanguageFilter languageFilter) {
    if (languageFilter == LanguageFilter.all) {
      return "All Words";
    } else if (languageFilter == LanguageFilter.arabicOnly) {
      return "Arabic Only";
    } else {
      return "English Only";
    }
  }
}
