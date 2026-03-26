import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:words_app/controllers/cubit/read_data_cubit.dart';
import 'package:words_app/views/styles/app_colors.dart';

class CustomFiltersIconButton extends StatelessWidget {
  const CustomFiltersIconButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => _CustomFiltersDialog(),
        );
      },
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: AppColors.white,
        ),
        child: Center(
          child: Icon(Icons.sort, color: AppColors.black, size: 24),
        ),
      ),
    );
  }
}

class _CustomFiltersDialog extends StatelessWidget {
  const _CustomFiltersDialog();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReadDataCubit, ReadDataState>(
      builder: (context, state) {
        return Dialog(
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _getSectionTitle("Language"),
                _getLanguageFilter(context),

                _getSectionTitle("Sorted By"),
                _getSortedBy(context),

                _getSectionTitle("Sorting By"),
                _getSortingBy(context),

                SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _getLanguageFilter(BuildContext context) {
    return _filterButton(
      labels: ["Arabic", "English", "All"],
      isSelected: [
        BlocProvider.of<ReadDataCubit>(context).languageFilter ==
            LanguageFilter.arabicOnly,
        BlocProvider.of<ReadDataCubit>(context).languageFilter ==
            LanguageFilter.englishOnly,
        BlocProvider.of<ReadDataCubit>(context).languageFilter ==
            LanguageFilter.all,
      ],
      onTaps: [
        () {
          BlocProvider.of<ReadDataCubit>(
            context,
          ).updateLanguageFilter(LanguageFilter.arabicOnly);
        },
        () {
          BlocProvider.of<ReadDataCubit>(
            context,
          ).updateLanguageFilter(LanguageFilter.englishOnly);
        },
        () {
          BlocProvider.of<ReadDataCubit>(
            context,
          ).updateLanguageFilter(LanguageFilter.all);
        },
      ],
    );
  }

  Widget _getSortedBy(BuildContext context) {
    return _filterButton(
      labels: ["Time", "Word Lenght"],
      isSelected: [
        BlocProvider.of<ReadDataCubit>(context).sortedBy == SortedBy.time,
        BlocProvider.of<ReadDataCubit>(context).sortedBy == SortedBy.length,
      ],
      onTaps: [
        () {
          BlocProvider.of<ReadDataCubit>(context).updateSortedBy(SortedBy.time);
        },
        () {
          BlocProvider.of<ReadDataCubit>(
            context,
          ).updateSortedBy(SortedBy.length);
        },
      ],
    );
  }

  Widget _getSortingBy(BuildContext context) {
    return _filterButton(
      labels: ["ascending", "descending"],
      isSelected: [
        BlocProvider.of<ReadDataCubit>(context).sortingType ==
            SortingType.ascending,
        BlocProvider.of<ReadDataCubit>(context).sortingType ==
            SortingType.descending,
      ],
      onTaps: [
        () {
          BlocProvider.of<ReadDataCubit>(
            context,
          ).updateSortingType(SortingType.ascending);
        },
        () {
          BlocProvider.of<ReadDataCubit>(
            context,
          ).updateSortingType(SortingType.descending);
        },
      ],
    );
  }

  Widget _getSectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppColors.white,
        ),
      ),
    );
  }

  Widget _filterButton({
    required List<String> labels,
    required List<bool> isSelected,
    required List<VoidCallback> onTaps,
  }) {
    return Row(
      children: [
        for (int i = 0; i < labels.length; i++)
          GestureDetector(
            onTap: onTaps[i],
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                padding: EdgeInsets.all(7),
                decoration: BoxDecoration(
                  color: isSelected[i]
                      ? AppColors.white
                      : AppColors.transparents,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    labels[i],
                    style: TextStyle(
                      color: isSelected[i] ? AppColors.black : AppColors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
