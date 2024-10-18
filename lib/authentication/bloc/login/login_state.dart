abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginSuccess extends LoginState {}

class LoginFailure extends LoginState {
  final String error;
  LoginFailure(this.error);
}

class PasswordVisible extends LoginState {}

class PasswordHidden extends LoginState {}

class RememberMeChecked extends LoginState {}

class RememberMeUnchecked extends LoginState {}


class GetSaveRememberMeSuccess extends LoginState {
   final String email;
  final String password;

  GetSaveRememberMeSuccess({required this.email, required this.password});

   @override
  List<Object> get props => [email, password];



}
