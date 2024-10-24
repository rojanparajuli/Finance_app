// lib/models/lending_model.dart

import 'package:cloud_firestore/cloud_firestore.dart';

class Lending {
  String id;
  String name;
  double amount;
  DateTime promisedDate;
  DateTime returnDate;

  Lending({
    required this.id,
    required this.name,
    required this.amount,
    required this.promisedDate,
    required this.returnDate,
  });

  factory Lending.fromMap(DocumentSnapshot data) {
    return Lending(
      id: data.id,
      name: data['name'] ?? '',
      amount: data['amount'] ?? 0.0,
      promisedDate: (data['promisedDate'] as Timestamp).toDate(),
      returnDate: (data['returnDate'] as Timestamp).toDate(),
    );
  }
}
