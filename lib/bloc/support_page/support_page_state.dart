import 'package:equatable/equatable.dart';

abstract class MessageState extends Equatable {
  @override
  List<Object?> get props => [];
}

class MessageInitial extends MessageState {}

class MessageSending extends MessageState {}

class MessageSent extends MessageState {}

class MessageError extends MessageState {
  final String error;

  MessageError(this.error);

  @override
  List<Object?> get props => [error];
}
