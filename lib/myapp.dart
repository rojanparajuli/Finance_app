import 'package:finance/animation/splash_screen.dart';
import 'package:finance/authentication/bloc/login_bloc.dart';
import 'package:finance/bloc/splash_screen_bloc.dart';
import 'package:finance/bloc/splash_screen_event.dart';
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
          BlocProvider<LoginBloc>(create: (context) => LoginBloc()),
        ],
      child: MaterialApp(
        title: 'Finance App',
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const SplashScreen(),
      
      ),
    );
  }
}
