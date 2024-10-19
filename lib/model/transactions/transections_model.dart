import 'package:cloud_firestore/cloud_firestore.dart';

class ShopTransaction {
  final String id;
  final String description;
  final double amount;
  final DateTime date;

  ShopTransaction({
    required this.id,
    required this.description,
    required this.amount,
    required this.date,
  });

  factory ShopTransaction.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ShopTransaction(
      id: doc.id,
      description: data['description'] ?? '',
      amount: (data['amount'] ?? 0).toDouble(),
      date: (data['date'] as Timestamp).toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'amount': amount,
      'date': date,
    };
  }
}
