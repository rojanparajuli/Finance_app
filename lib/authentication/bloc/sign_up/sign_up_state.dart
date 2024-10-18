import 'package:equatable/equatable.dart';

abstract class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => [];
}

class SignUpInitial extends SignUpState {}

class SignUpLoading extends SignUpState {}

class SignUpSuccess extends SignUpState {}

class SignUpFailure extends SignUpState {
  final String error;

  const SignUpFailure({required this.error});

  @override
  List<Object> get props => [error];
}

class SignUpFormUpdated extends SignUpState {
  final bool termsAccepted;

  const SignUpFormUpdated({required this.termsAccepted});

  @override
  List<Object> get props => [termsAccepted];
}

// Adding Google sign-up states
class GoogleSignUpInitial extends SignUpState {}

class GoogleSignUpLoading extends SignUpState {}

class GoogleSignUpSuccess extends SignUpState {}

class GoogleSignUpFailure extends SignUpState {
  final String error;

  const GoogleSignUpFailure({required this.error});

  @override
  List<Object> get props => [error];
}
