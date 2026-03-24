import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:words_app/controllers/cubit/write_data_cubit_cubit.dart';
import 'package:words_app/views/widgets/color_note_list.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: BlocBuilder<WriteDataCubitCubit, WriteDataCubitState>(
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
                ColorNoteList(
                  colorCode: BlocProvider.of<WriteDataCubitCubit>(
                    context,
                  ).colorCode,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
