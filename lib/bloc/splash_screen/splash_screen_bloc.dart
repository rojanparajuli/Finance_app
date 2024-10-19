import 'dart:async';
import 'package:finance/bloc/splash_screen/splash_screen_event.dart';
import 'package:finance/bloc/splash_screen/splash_screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashInitial()) {
    on<SplashStarted>(_onSplashStarted);
  }

  Future<void> _onSplashStarted(
      SplashStarted event, Emitter<SplashState> emit) async {
    emit(SplashLoading());

    try {
      await Future.delayed(const Duration(seconds: 3));

      emit(SplashCompleted());
    } catch (error) {
      emit(SplashInitial());
    }
  }
}
