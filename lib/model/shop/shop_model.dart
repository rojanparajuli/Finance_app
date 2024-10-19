import 'package:cloud_firestore/cloud_firestore.dart';

class Shop {
  final String? id; // Make id nullable
  final String name;
  final String description;

  Shop({
    this.id, // id is now optional
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  factory Shop.fromFirestore(DocumentSnapshot doc) {
    return Shop(
      id: doc.id,
      name: doc['name'],
      description: doc['description'],
    );
  }
}

