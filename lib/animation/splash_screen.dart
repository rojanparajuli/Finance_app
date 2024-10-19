import 'package:finance/authentication/view/login_screen.dart';
import 'package:finance/bloc/splash_screen_bloc.dart';
import 'package:finance/bloc/splash_screen_event.dart';
import 'package:finance/bloc/splash_screen_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SplashBloc()..add(SplashStarted()),
      child: const SplashView(),
    );
  }
}

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocListener<SplashBloc, SplashState>(
        listener: (context, state) {
          if (state is SplashCompleted) {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (_) => const LoginPage()),
            );
          }
        },
        child: Center(
          child: BlocBuilder<SplashBloc, SplashState>(
            builder: (context, state) {
              return AnimatedOpacity(
                opacity: state is SplashLoading ? 1.0 : 0.0,
                duration: const Duration(seconds: 2),
                child: Image.asset('assets/Firebase.png'),
              );
            },
          ),
        ),
      ),
    );
  }
}
