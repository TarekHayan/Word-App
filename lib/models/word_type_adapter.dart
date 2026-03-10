import 'package:hive_flutter/adapters.dart';
import 'package:words_app/models/word_model.dart';

class WordTypeAdapter extends TypeAdapter<WordModel> {
  @override
  WordModel read(BinaryReader reader) {
    final indexInDataBase = reader.readInt();
    final word = reader.readString();
    final isArabic = reader.readBool();
    final color = reader.readInt();
    final arabicSimilarWords = reader.readStringList();
    final englishSimilarWords = reader.readStringList();
    final arabicExampels = reader.readStringList();
    final englishExampels = reader.readStringList();

    return WordModel(
      indexInDataBase: indexInDataBase,
      word: word,
      isArabic: isArabic,
      color: color,
      arabicSimilarWords: arabicSimilarWords,
      englishSimilarWords: englishSimilarWords,
      arabicExampels: arabicExampels,
      englishExampels: englishExampels,
    );
  }

  @override
  int get typeId => 0;

  @override
  void write(BinaryWriter writer, WordModel obj) {
    writer.writeInt(obj.indexInDataBase);
    writer.writeString(obj.word);
    writer.writeBool(obj.isArabic);
    writer.writeInt(obj.color);
    writer.writeStringList(obj.arabicSimilarWords);
    writer.writeStringList(obj.englishSimilarWords);
    writer.writeStringList(obj.arabicExampels);
    writer.writeStringList(obj.englishExampels);
  }
}
