import 'package:cloud_firestore/cloud_firestore.dart';
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
        FirebaseFirestore.instance.collection('users').doc(_firebaseAuth.currentUser?.uid).set({
          'email': event.email,
          'name': event.fullName
        });

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
        emit(GoogleSignUpSuccess()); 
      } catch (e) {
        emit(GoogleSignUpFailure(error: e.toString())); 
      }
    });

    on<ToggleTermsAccepted>((event, emit) {
      emit(SignUpFormUpdated(termsAccepted: event.isAccepted));
    });

      

  }
}
