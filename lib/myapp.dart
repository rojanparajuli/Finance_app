import 'package:finance/animation/splash_screen.dart';
import 'package:finance/authentication/bloc/change_password/change_password_bloc.dart';
import 'package:finance/authentication/bloc/forget_password/forget_password_bloc.dart';
import 'package:finance/authentication/bloc/login/login_bloc.dart';
import 'package:finance/authentication/bloc/login/login_state.dart';
import 'package:finance/authentication/bloc/sign_up/sign_up_bloc.dart';
import 'package:finance/authentication/token/bloc/token_manager_bloc.dart';
import 'package:finance/authentication/token/bloc/token_manager_event.dart';
import 'package:finance/bloc/calculator/calculator_bloc.dart';
import 'package:finance/bloc/home/home_bloc.dart';
import 'package:finance/bloc/home/home_event.dart';
import 'package:finance/bloc/lending/lending_bloc.dart';
import 'package:finance/bloc/lending/lending_event.dart';
import 'package:finance/bloc/proile/profile_bloc.dart';
import 'package:finance/bloc/shop/shop_bloc.dart';
import 'package:finance/bloc/shop/shop_event.dart';
import 'package:finance/bloc/splash_screen/splash_screen_bloc.dart';
import 'package:finance/bloc/splash_screen/splash_screen_event.dart';
import 'package:finance/bloc/trasnsection/transection_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;

    return MultiBlocProvider(
      providers: [
        BlocProvider<SplashBloc>(
          create: (context) => SplashBloc()..add(SplashStarted()),
        ),
        BlocProvider(create: (context) => LoginBloc(FirebaseAuth.instance)),
        BlocProvider(create: (context) => SignUpBloc(FirebaseAuth.instance)),
        BlocProvider(
            create: (context) => ForgotPasswordBloc(FirebaseAuth.instance)),
        BlocProvider<ShopBloc>(
          create: (context) => ShopBloc(firestore)..add(LoadShops()),
        ),
        BlocProvider<TransactionBloc>(
          create: (context) => TransactionBloc(firestore),
        ),
        BlocProvider(create: (context) => QuoteBloc()..add(LoadQuote())),
        BlocProvider(create: (context) => TokenBloc()..add(GetToken())),
        BlocProvider(create: (context) => CalculatorBloc()),
        BlocProvider(
            create: (context) => LendingBloc(FirebaseFirestore.instance)
              ..add(LoadLendingsEvent())),
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(firestore),
        ),
        BlocProvider(create: (context) => PasswordBloc()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Finance App',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: BlocListener<LoginBloc, LoginState>(
          listener: (context, state) {
            if (state is LoginSuccess) {
              BlocProvider.of<ShopBloc>(context).add(LoadShops());
            }
          },
          child: const SplashScreen(),
        ),
      ),
    );
  }
}
