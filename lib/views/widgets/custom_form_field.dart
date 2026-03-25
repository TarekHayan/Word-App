import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/controllers/cubit/write_data_cubit_cubit.dart';
import 'package:words_app/views/styles/app_colors.dart';

class CustomFormField extends StatefulWidget {
  const CustomFormField({
    super.key,
    required this.label,
    required this.formKey,
  });
  final String label;
  final GlobalKey<FormState> formKey;

  @override
  State<CustomFormField> createState() => _CustomFormFieldState();
}

class _CustomFormFieldState extends State<CustomFormField> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: TextFormField(
        autofocus: true,
        controller: controller,
        minLines: 1,
        maxLines: 3,
        style: TextStyle(color: AppColors.white),
        cursorColor: AppColors.white,
        decoration: InputDecoration(
          labelText: widget.label,
          labelStyle: TextStyle(color: AppColors.white),
          hintStyle: TextStyle(color: AppColors.white),
          hintText: widget.label.toLowerCase(),
          border: _customInPutDecoration(AppColors.white),
          focusedBorder: _customInPutDecoration(AppColors.white),
          enabledBorder: _customInPutDecoration(AppColors.white),
          errorBorder: _customInPutDecoration(AppColors.red),
        ),
        onChanged: (value) =>
            BlocProvider.of<WriteDataCubitCubit>(context).updateText(value),
        validator: (value) {
          return _checkValidator(
            value,
            BlocProvider.of<WriteDataCubitCubit>(context).isArabic,
          );
        },
      ),
    );
  }

  String? _checkValidator(String? value, bool isArabic) {
    final arabic = RegExp(r'[\u0600-\u06FF]');
    final english = RegExp(r'[A-Za-z]');
    if (value == null || value.trim().isEmpty) {
      return "lenght is 0";
    }

    if (arabic.hasMatch(value) && isArabic == false) {
      return "this word is arabic";
    } else if (english.hasMatch(value) && isArabic == true) {
      return "this word is arabic";
    }

    return null;
  }

  OutlineInputBorder _customInPutDecoration(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: color, width: 2),
    );
  }
}
