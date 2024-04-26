import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'cubit_state.dart';

class CubitCubit extends Cubit<CubitState> {
  CubitCubit() : super(CubitInitial());
  Future<void> loginUser(
      {required String email, required String password}) async {
    var auth = FirebaseAuth.instance;
    emit(CubitLoading());
    try {
      // ignore: unused_local_variable
      UserCredential user = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(CubitSuccess());
    }on FirebaseAuthException catch (ex) {
                              if (ex.code == 'user-not-found') {
                                emit(CubitFailure(errMessage: 'user not found'));
                              } else if (ex.code == 'wrong-password') {
                               emit(CubitFailure(errMessage: 'wrong-password'));
                              } else {
                              }
                            }
    catch (e) {
      emit(CubitFailure(errMessage: 'something went wrong'));
    }
  }
}
