import 'package:equatable/equatable.dart';

abstract class MessageEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SendMessage extends MessageEvent {
  final String user;
  final String content;

  SendMessage({required this.user, required this.content});

  @override
  List<Object?> get props => [user, content];
}
