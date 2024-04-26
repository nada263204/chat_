import 'package:flutter/material.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/cubits/login_cubit/cubit_cubit.dart';
import 'package:scholar_chat/screens/cubits/register_cubit/register_cubit_cubit.dart';
import 'package:scholar_chat/screens/login_screen.dart';
import 'package:scholar_chat/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CubitCubit(),
        ),
        BlocProvider(
          create: (context) => RegisterCubitCubit(),
        ),
      ],
      child: MaterialApp(
          routes: {
            'LoginScreen': (context) => loginScreen(),
            'RegisterScreen': (context) => RegisterScreen(),
            chatScreen.id: (context) => chatScreen(),
          },
          initialRoute: 'LoginScreen',
          debugShowCheckedModeBanner: false,
          home: loginScreen()),
    );
  }
}
