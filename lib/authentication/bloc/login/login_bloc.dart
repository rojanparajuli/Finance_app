import 'package:bloc/bloc.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth;

  LoginBloc(this._firebaseAuth) : super(LoginInitial()){
    on<LoginSubmitted>(mapEventToState);
  }


  Future<void> mapEventToState(LoginSubmitted event, Emitter<LoginState> emit) async {
   
     emit(LoginLoading());
      try {
        await _firebaseAuth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(LoginSuccess());
        
      } catch (error) {
        emit(LoginFailure(error.toString()));
        
      }
    
  }
}
