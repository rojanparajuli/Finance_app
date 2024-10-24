import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finance/model/support/support_model.dart';

class MessageRepository {
  final FirebaseFirestore firestore;

  MessageRepository({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;

  Future<void> sendMessage(Message message) async {
    await firestore.collection('messages').add(message.toMap());
  }
}
