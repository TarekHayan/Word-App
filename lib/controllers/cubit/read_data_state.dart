part of 'read_data_cubit.dart';

@immutable
sealed class ReadDataState {}

final class ReadDataInitial extends ReadDataState {}

final class ReadDataLoading extends ReadDataState {}

final class ReadDataSucess extends ReadDataState {
  final List<WordModel> words;

  ReadDataSucess({required this.words});
}

final class ReadDatafauliar extends ReadDataState {
  final String error;

  ReadDatafauliar({required this.error});
}
