abstract class LoginEvent {}

class LoginSubmitted extends LoginEvent {
  final String email;
  final String password;
  final bool rememberMe;

  LoginSubmitted(this.email, this.password, this.rememberMe);
}

class PasswordVisibilityChanged extends LoginEvent {
  final bool isVisible;
  PasswordVisibilityChanged(this.isVisible);
}

class RememberMeChanged extends LoginEvent {
  bool isRemember;

  RememberMeChanged({required this.isRemember});

  @override
  List<Object> get props => [isRemember];
}

class SaveRememberMe extends LoginEvent {
  final String message;
  final String email;
  final String password;

  SaveRememberMe(
      {required this.email, required this.password, required this.message});

  @override
  List<Object> get props => [email, password, message];
}

class RemoveSavedRememberMe extends LoginEvent {
  final String message;

  RemoveSavedRememberMe({required this.message});
  @override
  List<Object> get props => [message];
}

class GetRememberMe extends LoginEvent {
  GetRememberMe();

  @override
  List<Object> get props => [];
}
