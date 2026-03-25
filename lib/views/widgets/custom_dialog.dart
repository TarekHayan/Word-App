import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/controllers/cubit/read_data_cubit.dart';
import 'package:words_app/controllers/cubit/write_data_cubit_cubit.dart';
import 'package:words_app/core/widgets/custom_snak_bar.dart';
import 'package:words_app/views/widgets/color_note_list.dart';
import 'package:words_app/views/widgets/custom_form_field.dart';
import 'package:words_app/views/widgets/done_button.dart';
import 'package:words_app/views/widgets/language_note_item.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocConsumer<WriteDataCubitCubit, WriteDataCubitState>(
        listener: (context, state) {
          if (state is WriteDataCubitSucess) {
            Navigator.pop(context);
            CustomSnackBar.show(
              context,
              message: "add word sucess",
              type: SnackBarType.success,
            );
          }
          if (state is WriteDataCubitfuliar) {
            CustomSnackBar.show(
              context,
              message: state.msgError,
              type: SnackBarType.error,
            );
          }
        },
        builder: (context, state) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 750),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Color(
                BlocProvider.of<WriteDataCubitCubit>(context).colorCode,
              ),
            ),
            padding: EdgeInsets.all(15),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                LanguageNoteItems(
                  isSelectdArabic: BlocProvider.of<WriteDataCubitCubit>(
                    context,
                  ).isArabic,
                ),
                SizedBox(height: 15),
                ColorNoteList(
                  colorCode: BlocProvider.of<WriteDataCubitCubit>(
                    context,
                  ).colorCode,
                ),

                SizedBox(height: 20),
                CustomFormField(label: "new Word", formKey: formKey),
                SizedBox(height: 40),
                Align(
                  alignment: AlignmentDirectional.bottomEnd,
                  child: DoneButton(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        BlocProvider.of<WriteDataCubitCubit>(context).addWord();
                        BlocProvider.of<ReadDataCubit>(context).getWords();
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
