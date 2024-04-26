// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scholar_chat/constatnts.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/cubits/register_cubit/register_cubit_cubit.dart';
import 'package:scholar_chat/widgets/customButton.dart';
import 'package:scholar_chat/widgets/customtextfield.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegisterScreen extends StatelessWidget {
  static String id = 'LoginScreen';

  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegisterCubitCubit, RegisterCubitState>(
      listener: (context, state) {
        if(state is RegisterLoading){
          isLoading =true;
        }
        else if(state is RegisterSuccess)
        {
          Navigator.pushNamed(context, chatScreen.id);
          isLoading =false;
        }
        else if(state is RegisterFailure){
          showSnackBar(context,state.errMessage);
          isLoading =false;
        }
      },
      builder: (context, state) {
        return ModalProgressHUD(
          inAsyncCall: isLoading,
          child: Scaffold(
            backgroundColor: kPrimaryColor,
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Form(
                  key: formKey,
                  child: ListView(children: [
                    Column(
                      children: [
                        Image.asset('assets/images/scholar.png'),
                        Text(
                          'Scholar Chatting App',
                          style: TextStyle(
                            fontSize: 32,
                            color: Colors.white,
                            fontFamily: 'Pacifico',
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTextFormField(
                          onChanged: (data) {
                            email = data;
                          },
                          hintText: 'Email',
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextFormField(
                          onChanged: (data) {
                            password = data;
                          },
                          hintText: 'Password',
                        ),
                        customButton(
                          text: 'Register',
                          onClicked: () async {
                            if (formKey.currentState!.validate()) {
                              BlocProvider.of<RegisterCubitCubit>(context)
                                  .registerUser(
                                      email: email!, password: password!);
                            }
                          },
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'already have an account?',
                              style: TextStyle(color: Colors.white),
                            ),
                            GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Text(
                                '  Login',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 164, 230, 219)),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ]),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> registerUser() async {
    var auth = FirebaseAuth.instance;
    UserCredential user = await auth.createUserWithEmailAndPassword(
        email: email!, password: password!);
  }
}
