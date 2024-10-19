import 'package:finance/animation/splash_screen.dart';
import 'package:finance/authentication/bloc/forget_password/forget_password_bloc.dart';
import 'package:finance/authentication/bloc/login/login_bloc.dart';
import 'package:finance/authentication/bloc/sign_up/sign_up_bloc.dart';
import 'package:finance/bloc/splash_screen_bloc.dart';
import 'package:finance/bloc/splash_screen_event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc()..add(SplashStarted()),
        ),
        BlocProvider(create: (context) => LoginBloc(FirebaseAuth.instance)),
        BlocProvider(create: (context) => SignUpBloc(FirebaseAuth.instance)),
        BlocProvider(
      create: (context) => ForgotPasswordBloc(FirebaseAuth.instance)),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Finance App',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      ),
    );
  }
}
