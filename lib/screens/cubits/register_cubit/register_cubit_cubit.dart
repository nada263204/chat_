import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

part 'register_cubit_state.dart';

class RegisterCubitCubit extends Cubit<RegisterCubitState> {
  RegisterCubitCubit() : super(RegisterCubitInitial());

  Future<void> registerUser({required String email, required String password}) async {
    emit(RegisterLoading());
     try {
  var auth = FirebaseAuth.instance;
                     // ignore: unused_local_variable
                     UserCredential user = await
                     auth.createUserWithEmailAndPassword(email: email ,password: password);
} on FirebaseAuthException catch (ex){
       if(ex.code == 'weak-password'){
        emit(RegisterFailure(errMessage: 'Weak password'));
       }
       else if(ex.code == 'email-already-in-use'){
        emit(RegisterFailure(errMessage: 'email-already-exist'));
       }else{
        emit(RegisterSuccess());
       }
        }catch(e){
      emit(RegisterFailure(errMessage: 'there was an error please try again'));
        }
  }
}
