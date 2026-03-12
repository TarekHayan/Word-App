part of 'write_data_cubit_cubit.dart';

@immutable
sealed class WriteDataCubitState {}

final class WriteDataCubitInitial extends WriteDataCubitState {}

final class WriteDataCubitLoading extends WriteDataCubitState {}

final class WriteDataCubitSucess extends WriteDataCubitState {}

final class WriteDataCubitfuliar extends WriteDataCubitState {
  final String msgError;

  WriteDataCubitfuliar({required this.msgError});
}
