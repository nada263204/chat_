// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/constatnts.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/cubits/login_cubit/cubit_cubit.dart';
import 'package:scholar_chat/screens/register_screen.dart';

import 'package:scholar_chat/widgets/customButton.dart';
import 'package:scholar_chat/widgets/customtextfield.dart';

// ignore: must_be_immutable
class loginScreen extends StatelessWidget {
  String? email;

  String? password;

  bool isLoading = false;

  GlobalKey<FormState> formKey = GlobalKey();

  loginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CubitCubit, CubitState>(
      listener: (context, state) {
        if(state is CubitLoading){
          isLoading =true;
        }
        else if(state is CubitSuccess)
        {
          Navigator.pushNamed(context, chatScreen.id);
          isLoading =false;
        }
        else if(state is CubitFailure){
          showSnackBar(context,state.errMessage);
          isLoading =false;
        }
      },
      // ignore: avoid_types_as_parameter_names
      builder: (context,state) => ModalProgressHUD(
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
                        children: const [
                          Text(
                            'Login',
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
                        text: 'Login',
                        onClicked: () async {
                          if (formKey.currentState!.validate()) {
                            try {
                              // await loginUser();
                              Navigator.pushNamed(context, chatScreen.id,
                                  arguments: email);
                            } on FirebaseAuthException catch (ex) {
                              isLoading = true;
                              if (ex.code == 'user-not-found') {
                                showSnackBar(context, 'user not found');
                              } else if (ex.code == 'wrong-password') {
                                showSnackBar(
                                    context, 'wrong password try again');
                              } else {
                                showSnackBar(context, 'success');
                              }
                            } catch (e) {
                              showSnackBar(context, 'Ops,there was an error!');
                            }
                            isLoading = false;
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
                            'don\'t have an account',
                            style: TextStyle(color: Colors.white),
                          ),
                          GestureDetector(
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()),
                            ),
                            child: Text(
                              '  Register',
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
      ),
    );
  }

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
