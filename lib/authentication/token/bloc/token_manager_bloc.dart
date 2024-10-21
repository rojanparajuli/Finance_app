import 'package:bloc/bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart'; 
import 'token_manager_event.dart';
import 'token_manager_state.dart';

class TokenBloc extends Bloc<TokenEvent, TokenState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  TokenBloc() : super(TokenInitial()) {
    on<SaveToken>(_onSaveToken);
    on<RemoveToken>(_onRemoveToken);
    on<GetToken>(_onGetToken);
  }

  Future<void> _onSaveToken(SaveToken event, Emitter<TokenState> emit) async {
    emit(TokenLoading()); 

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('auth_token', event.token);

      emit(TokenSaved());
    } catch (error) {
      emit(TokenError(error: 'Failed to save token: $error'));
    }
  }

  Future<void> _onRemoveToken(RemoveToken event, Emitter<TokenState> emit) async {
    emit(TokenLoading());

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('auth_token');

      await _firebaseAuth.signOut();

      emit(TokenRemoved());
    } catch (error) {
      emit(TokenError(error: 'Failed to remove token: $error'));
    }
  }

  Future<void> _onGetToken(GetToken event, Emitter<TokenState> emit) async {
    emit(TokenLoading());
    try {
      final prefs = await SharedPreferences.getInstance();
      final String? token = prefs.getString('auth_token'); 

      if (token != null && token.isNotEmpty) {
        emit(TokenRetrieved(token: token)); 
      } else {
        final User? user = _firebaseAuth.currentUser;
        if (user != null) {
          final idToken = await user.getIdToken();
          emit(TokenRetrieved(token: idToken ??''));
        } else {
          emit(TokenError(error: 'No token found.'));
        }
      }
    } catch (error) {
      emit(TokenError(error: 'Failed to retrieve token: $error'));
    }
  }
}
