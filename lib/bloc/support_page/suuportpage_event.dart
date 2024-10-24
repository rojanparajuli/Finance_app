import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMessage extends MessageEvent {
  final String email;
  final String content;

  SendMessage({required this.email, required this.content});

  @override
  List<Object?> get props => [email, content];
}
