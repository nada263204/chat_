part of 'cubit_cubit.dart';

@immutable
abstract class CubitState {}

 class CubitInitial extends CubitState {}
 class CubitSuccess extends CubitState {}
 class CubitLoading extends CubitState {}
 // ignore: must_be_immutable
 class CubitFailure extends CubitState {
  String errMessage;
  CubitFailure({required this.errMessage});
 }
