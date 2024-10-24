import 'package:equatable/equatable.dart';

abstract class PasswordState extends Equatable {
  @override
  List<Object> get props => [];
}

class PasswordInitial extends PasswordState {}

class PasswordLoading extends PasswordState {}

class PasswordChanged extends PasswordState {}

class PasswordError extends PasswordState {
  final String message;

  PasswordError(this.message);

  @override
  List<Object> get props => [message];
}
