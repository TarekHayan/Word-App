import 'package:flutter/material.dart';
import 'package:words_app/views/styles/app_colors.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 40,
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Center(
          child: Text("Done", style: TextStyle(color: AppColors.black)),
        ),
      ),
    );
  }
}
