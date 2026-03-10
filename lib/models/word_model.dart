class WordModel {
  final int indexInDataBase;
  final String word;
  final bool isArabic;
  final int color;
  final List<String> arabicSimilarWords;
  final List<String> englishSimilarWords;
  final List<String> arabicExampels;
  final List<String> englishExampels;

  const WordModel({
    required this.indexInDataBase,
    required this.word,
    required this.isArabic,
    required this.color,
    this.arabicSimilarWords = const [],
    this.englishSimilarWords = const [],
    this.arabicExampels = const [],
    this.englishExampels = const [],
  });

  WordModel decrementIndexAtDataBase() {
    return WordModel(
      indexInDataBase: indexInDataBase - 1,
      word: word,
      isArabic: isArabic,
      color: color,
    );
  }

  List<String> _intialaizNewWords(bool isArabicSimilarWord, bool isSimilar) {
    List<String> newWords;
    if (isArabicSimilarWord) {
      newWords = isSimilar
          ? List.from(arabicSimilarWords)
          : List.from(arabicExampels);
    } else {
      newWords = isSimilar
          ? List.from(englishSimilarWords)
          : List.from(englishExampels);
    }
    return newWords;
  }

  WordModel _getWordAfterCheck(
    bool isArabicWord,
    List<String> newWords,
    bool isSimilar,
  ) {
    return WordModel(
      indexInDataBase: indexInDataBase,
      word: word,
      isArabic: isArabic,
      color: color,
      arabicSimilarWords: isSimilar
          ? isArabicWord
                ? newWords
                : arabicSimilarWords
          : arabicSimilarWords,
      englishSimilarWords: isSimilar
          ? !isArabicWord
                ? newWords
                : englishSimilarWords
          : englishSimilarWords,
      arabicExampels: !isSimilar
          ? isArabicWord
                ? newWords
                : arabicExampels
          : arabicExampels,
      englishExampels: !isSimilar
          ? !isArabicWord
                ? newWords
                : englishExampels
          : englishExampels,
    );
  }

  WordModel deletSimilarWord(int index, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _intialaizNewWords(
      isArabicSimilarWord,
      true,
    );
    newSimilarWords.removeAt(index);
    return _getWordAfterCheck(isArabicSimilarWord, newSimilarWords, true);
  }

  WordModel addSimilarWord(String newSimilarWord, bool isArabicSimilarWord) {
    List<String> newSimilarWords = _intialaizNewWords(
      isArabicSimilarWord,
      true,
    );

    newSimilarWords.add(newSimilarWord);

    return _getWordAfterCheck(isArabicSimilarWord, newSimilarWords, true);
  }

  WordModel addExampleWord(String newExample, bool isArabicExample) {
    List<String> newExamples = _intialaizNewWords(isArabicExample, false);

    newExamples.add(newExample);

    return _getWordAfterCheck(isArabicExample, newExamples, false);
  }
}
