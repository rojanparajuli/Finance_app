import 'package:bloc/bloc.dart';
import 'package:finance/authentication/bloc/forget_password/forget_password_event.dart';
import 'package:finance/authentication/bloc/forget_password/forget_password_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  final FirebaseAuth _firebaseAuth;

  ForgotPasswordBloc(this._firebaseAuth) : super(ForgotPasswordInitial()) {
    on<ForgotPasswordEmailSubmitted>(_onForgotPasswordEmailSubmitted);
  }
  Future<void> _onForgotPasswordEmailSubmitted(
    ForgotPasswordEmailSubmitted event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(ForgotPasswordLoading());
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: event.email);
      emit(ForgotPasswordSuccess());
    } catch (error) {
      emit(ForgotPasswordFailure(error.toString()));
    }
  }
}
