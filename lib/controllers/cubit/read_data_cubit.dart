import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:words_app/models/hive_details.dart';
import 'package:words_app/models/word_model.dart';

part 'read_data_state.dart';

class ReadDataCubit extends Cubit<ReadDataState> {
  ReadDataCubit() : super(ReadDataInitial());
  final Box _box = Hive.box(HiveDetails.boxName);
  LanguageFilter languageFilter = LanguageFilter.all;
  SortedBy sortedBy = SortedBy.time;
  SortingType sortingType = SortingType.descending;

  void updateLanguageFilter(LanguageFilter languageFilter) {
    this.languageFilter = languageFilter;
  }

  void updateSortedBy(SortedBy sortedBy) {
    this.sortedBy = sortedBy;
  }

  void updateSortingType(SortingType sortingType) {
    this.sortingType = sortingType;
  }

  void getWords() {
    emit(ReadDataLoading());
    try {
      List<WordModel> words = List.from(
        _box.get(HiveDetails.wordsList, defaultValue: []),
      ).cast<WordModel>();
      _removewords(words);
      _applySorting(words);
      emit(ReadDataSucess(words: words));
      for (int i = 0; i < words.length; i++) {
        print("-----------------------");
        print(words[i].indexInDataBase);
        print(words[i].word);
        print(words[i].isArabic);
        print(words[i].color);
      }
    } catch (e) {
      emit(ReadDatafauliar(error: "something Wrong In Get try again later"));
    }
  }

  void _removewords(List<WordModel> words) {
    if (languageFilter == LanguageFilter.all) {
      return;
    }
    for (int i = 0; i < words.length; i++) {
      if ((languageFilter == LanguageFilter.arabicOnly &&
              words[i].isArabic == false) ||
          (languageFilter == LanguageFilter.englishOnly &&
              words[i].isArabic == true)) {
        words.removeAt(i);
        i--;
      }
    }
  }

  void _applySorting(List<WordModel> words) {
    if (sortedBy == SortedBy.time) {
      if (sortingType == SortingType.descending) {
        return;
      } else {
        words = words.reversed.toList();
      }
    } else {
      words.sort(
        (WordModel a, WordModel b) => a.word.length.compareTo(b.word.length),
      );
      if (sortingType == SortingType.descending) {
        return;
      } else {
        words = words.reversed.toList();
      }
    }
  }
}

enum LanguageFilter { arabicOnly, englishOnly, all }

enum SortedBy { time, length }

enum SortingType { asending, descending }
