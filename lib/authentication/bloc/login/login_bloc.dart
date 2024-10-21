import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_event.dart';
import 'login_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final FirebaseAuth _firebaseAuth;

  LoginBloc(this._firebaseAuth) : super(LoginInitial()) {
    on<LoginSubmitted>(mapEventToState);
    on<PasswordVisibilityChanged>(mapPasswordVisibilityToState);
    on<RememberMeChanged>(mapRememberMeToState);
    on<SaveRememberMe>(_onSaveRememberMe);
    on<RemoveSavedRememberMe>(_onRemoveSavedRememberMe);
    on<GetRememberMe>(_onGetRememberMe);
  }

  Future<void> mapEventToState(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(LoginLoading());

    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: event.email,
        password: event.password,
      );

      if (event.rememberMe) {
        add(SaveRememberMe(message:'save', email: event.email, password: event.password
        ));
      }

      emit(LoginSuccess());
    } catch (error) {
      emit(LoginFailure(error.toString()));
    }
  }

  void mapPasswordVisibilityToState(PasswordVisibilityChanged event, Emitter<LoginState> emit) {
    if (event.isVisible) {
      emit(PasswordVisible());
    } else {
      emit(PasswordHidden());
    }
  }

  void mapRememberMeToState(RememberMeChanged event, Emitter<LoginState> emit) {
    if (event.isRemember) {
      emit(RememberMeChecked());
    } else {
      emit(RememberMeUnchecked());
    }
  }

  Future<void> _onSaveRememberMe(SaveRememberMe event, Emitter<LoginState> emit) async {
     final prefs = await SharedPreferences.getInstance();
     prefs.setString('email', event.email);
        prefs.setString('password', event.password);
  }

  Future<void> _onGetRememberMe(GetRememberMe event, Emitter<LoginState> emit) async {
     final prefs = await SharedPreferences.getInstance();
     final email = prefs.getString('email');
     final password = prefs.getString('password');

     if (email != null || password != null){
      emit(GetSaveRememberMeSuccess(email: email ?? '', password: password ?? '',));
      
     }

  }



  Future<void>  _onRemoveSavedRememberMe (RemoveSavedRememberMe event, Emitter<LoginState> emit) async {

      final prefs = await SharedPreferences.getInstance();
     prefs.remove('email');
      prefs.remove('password');

  }
  
}
