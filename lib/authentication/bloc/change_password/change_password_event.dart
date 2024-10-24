import 'package:equatable/equatable.dart';

abstract class PasswordEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ChangePasswordEvent extends PasswordEvent {
  final String oldPassword;
  final String newPassword;

  ChangePasswordEvent(this.oldPassword, this.newPassword);

  @override
  List<Object> get props => [oldPassword, newPassword];
}
