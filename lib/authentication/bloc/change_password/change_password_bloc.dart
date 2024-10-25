import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:finance/authentication/bloc/change_password/change_password_event.dart';
import 'package:finance/authentication/bloc/change_password/change_password_state.dart';

class PasswordBloc extends Bloc<PasswordEvent, PasswordState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  PasswordBloc() : super(PasswordInitial()) {
    on<ChangePasswordEvent>(_onChangePasswordEvent);
  }

Future<void> _onChangePasswordEvent(
    ChangePasswordEvent event, Emitter<PasswordState> emit) async {
  emit(PasswordLoading());

  try {
    User? user = _auth.currentUser;

    if (user == null) {
      emit(PasswordError("No user is currently signed in."));
      return;
    }

    print('old password is ${event.oldPassword}');

    AuthCredential credential = EmailAuthProvider.credential(
      email: user.email!,
      password: event.oldPassword,
    );

    await user.reauthenticateWithCredential(credential);

    await user.updatePassword(event.newPassword);
    emit(PasswordChanged());
  } catch (e) {
    String errorMessage = '';

    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'wrong-password':
          errorMessage = "The old password is incorrect.";
          break;
        case 'user-not-found':
          errorMessage = "No user found for the provided email.";
          break;
        case 'too-many-requests':
          errorMessage = "Too many requests. Please try again later.";
          break;
        case 'invalid-email':
          errorMessage = "The email address is malformed.";
          break;
        default:
          errorMessage = "An error occurred: ${e.message}";
      }
    } else {
      errorMessage = "An unknown error occurred: ${e.toString()}";
    }

    emit(PasswordError(errorMessage));
  }
}


}
