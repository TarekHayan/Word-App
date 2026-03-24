import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/controllers/cubit/write_data_cubit_cubit.dart';

class LanguageNoteItems extends StatelessWidget {
  const LanguageNoteItems({super.key, required this.isSelectdArabic});
  final bool isSelectdArabic;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _languageNoteItem(true, context),
        SizedBox(width: 10),
        _languageNoteItem(false, context),
      ],
    );
  }

  GestureDetector _languageNoteItem(bool isSelectedAr, BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isSelectedAr != isSelectdArabic) {
          BlocProvider.of<WriteDataCubitCubit>(
            context,
          ).updateLanguage(isSelectedAr);
        }
      },
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelectedAr == isSelectdArabic
              ? Colors.white
              : Colors.transparent,
          border: Border.all(color: Colors.white, width: 2),
        ),
        child: Center(
          child: Text(
            isSelectedAr ? "ar" : "en",
            style: TextStyle(
              color: (isSelectedAr == isSelectdArabic)
                  ? Color(
                      BlocProvider.of<WriteDataCubitCubit>(context).colorCode,
                    )
                  : Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
