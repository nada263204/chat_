part of 'register_cubit_cubit.dart';

@immutable
abstract class RegisterCubitState {}

class RegisterCubitInitial extends RegisterCubitState {}
class RegisterSuccess extends RegisterCubitState {}
 class RegisterLoading extends RegisterCubitState {}
 // ignore: must_be_immutable
 class RegisterFailure extends RegisterCubitState {
  String errMessage;
  RegisterFailure({required this.errMessage});
 }