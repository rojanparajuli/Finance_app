import 'package:equatable/equatable.dart';

abstract class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => [];
}

class SignUpSubmitted extends SignUpEvent {
  final String email;
  final String password;
  final String fullName;

  const SignUpSubmitted(this.email, this.password, this.fullName);

  @override
  List<Object> get props => [email, password, fullName];
}

class GoogleSignUpSubmitted extends SignUpEvent {}

class ToggleTermsAccepted extends SignUpEvent {
  final bool isAccepted;

  const ToggleTermsAccepted(this.isAccepted);

  @override
  List<Object> get props => [isAccepted];
}
