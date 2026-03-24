import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:meta/meta.dart';
import 'package:words_app/models/hive_details.dart';
import 'package:words_app/models/word_model.dart';

part 'write_data_cubit_state.dart';

class WriteDataCubitCubit extends Cubit<WriteDataCubitState> {
  WriteDataCubitCubit() : super(WriteDataCubitInitial());
  final Box box = Hive.box(HiveDetails.boxName);
  String word = "";
  bool isArabic = true;
  int colorCode = 0xff62B6CB;

  void updateText(String text) {
    word = text;
  }

  void updateLanguage(bool isArabic) {
    this.isArabic = isArabic;
  }

  void updateColor(int colorCode) {
    this.colorCode = colorCode;
    emit(WriteDataCubitInitial());
  }

  void addWord() {
    _tryAndCatch(() {
      List<WordModel> words = _getWordsListFromDataBase();
      words.add(
        WordModel(
          indexInDataBase: words.length,
          word: word,
          isArabic: isArabic,
          color: colorCode,
        ),
      );
      box.put(HiveDetails.wordsList, words);
    }, "Somthing wrong try again");
  }

  void deletWord(int indexDataBase) {
    _tryAndCatch(() {
      List<WordModel> words = _getWordsListFromDataBase();
      box.deleteAt(indexDataBase);
      for (int i = indexDataBase; i < words.length; i++) {
        words[i] = words[i].decrementIndexAtDataBase();
      }
      box.put(HiveDetails.wordsList, words);
    }, "Somthing wrong try again");
  }

  void addSimilarWord(int indexInDataBase) {
    List<WordModel> words = _getWordsListFromDataBase();
    _tryAndCatch(() {
      words[indexInDataBase] = words[indexInDataBase].addSimilarWord(
        word,
        isArabic,
      );
      box.put(HiveDetails.wordsList, words);
    }, "Somthing wrong try again");
  }

  void addExampel(int indexInDataBase) {
    List<WordModel> words = _getWordsListFromDataBase();
    _tryAndCatch(() {
      words[indexInDataBase] = words[indexInDataBase].addExampleWord(
        word,
        isArabic,
      );
      box.put(HiveDetails.wordsList, words);
    }, "Somthing wrong try again");
  }

  void deletSimilarWord(
    int indexInDataBase,
    int indexInSimilar,
    bool isArabic,
  ) {
    _tryAndCatch(() {
      List<WordModel> words = _getWordsListFromDataBase();
      words[indexInDataBase] = words[indexInDataBase].deletSimilarWord(
        indexInSimilar,
        isArabic,
      );
    }, "Somthing wrong try again");
  }

  void deletExampel(int indexInDataBase, int indexInSimilar, bool isArabic) {
    _tryAndCatch(() {
      List<WordModel> words = _getWordsListFromDataBase();
      words[indexInDataBase] = words[indexInDataBase].deletExampelWord(
        indexInSimilar,
        isArabic,
      );
    }, "Somthing wrong try again");
  }

  void _tryAndCatch(VoidCallback methoud, String msg) {
    emit(WriteDataCubitLoading());

    try {
      methoud.call();
      emit(WriteDataCubitSucess());
    } catch (e) {
      emit(WriteDataCubitfuliar(msgError: msg));
    }
  }

  List<WordModel> _getWordsListFromDataBase() {
    return List.from(
      box.get(HiveDetails.wordsList, defaultValue: []),
    ).cast<WordModel>();
  }
}
