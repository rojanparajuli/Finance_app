import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'sign_up_event.dart';
import 'sign_up_state.dart';

class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  final FirebaseAuth _firebaseAuth;

  SignUpBloc(this._firebaseAuth) : super(SignUpInitial()) {
    on<SignUpSubmitted>((event, emit) async {
      emit(SignUpLoading());
      try {
        await _firebaseAuth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure(error: e.toString()));
      }
    });

    on<GoogleSignUpSubmitted>((event, emit) async {
      emit(GoogleSignUpLoading()); 
      try {
        final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
        if (googleUser == null) {
          emit(const GoogleSignUpFailure(error: 'Google Sign-In canceled.'));
          return;
        }
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _firebaseAuth.signInWithCredential(credential);
        emit(GoogleSignUpSuccess()); // Show success state
      } catch (e) {
        emit(GoogleSignUpFailure(error: e.toString())); // Show failure state
      }
    });

    on<ToggleTermsAccepted>((event, emit) {
      emit(SignUpFormUpdated(termsAccepted: event.isAccepted));
    });
  }
}
