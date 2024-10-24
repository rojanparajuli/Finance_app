import 'package:finance/bloc/support_page/support_page_state.dart';
import 'package:finance/bloc/support_page/suuportpage_event.dart';
import 'package:finance/model/support/support_model.dart';
import 'package:finance/repository/message_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository repository;

  MessageBloc(this.repository) : super(MessageInitial());

  @override
  Stream<MessageState> mapEventToState(MessageEvent event) async* {
    if (event is SendMessage) {
      yield MessageSending();
      try {
        final message = Message(email: event.email, content: event.content);
        await repository.sendMessage(message);
        yield MessageSent();
      } catch (e) {
        yield MessageError(e.toString());
      }
    }
  }
}
