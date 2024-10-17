import 'package:finance/authentication/bloc/login_event.dart';
import 'package:finance/authentication/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(LoginInitial());

  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      await Future.delayed(const Duration(seconds: 2));
    }
  }
}
