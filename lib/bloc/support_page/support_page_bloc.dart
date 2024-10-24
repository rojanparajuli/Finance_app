import 'package:finance/bloc/support_page/support_page_state.dart';
import 'package:finance/bloc/support_page/suuportpage_event.dart';
import 'package:finance/model/support/support_model.dart';
import 'package:finance/repository/message_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository repository;

  MessageBloc(this.repository) : super(MessageInitial()) {
    on<SendMessage>((event, emit) async {
      emit(MessageSending());
      try {
        final message = Message(email: event.user, content: event.content);
        await repository.sendMessage(message);
        emit(MessageSent());
      } catch (e) {
        emit(MessageError(e.toString()));
      }
    });
  }
}
