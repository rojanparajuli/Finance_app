// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:finance/model/lending/lending_model.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:image_picker/image_picker.dart';
// import 'dart:io';

// class FirebaseService {
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<void> addLendingEntry(LendingEntry entry) async {
//     await _firestore.collection('lendingEntries').add(entry.toMap());
//   }

//   Future<void> updateLendingEntry(LendingEntry entry) async {
//     await _firestore
//         .collection('lendingEntries')
//         .doc(entry.id)
//         .update(entry.toMap());
//   }

//   Future<void> deleteLendingEntry(String id) async {
//     await _firestore.collection('lendingEntries').doc(id).delete();
//   }

//   Future<String?> uploadImage(XFile image) async {
//     final ref =
//         FirebaseStorage.instance.ref().child('statement_images/${image.name}');
//     await ref.putFile(File(image.path));
//     return await ref.getDownloadURL();
//   }

//   Stream<List<LendingEntry>> getLendingEntries() {
//     return _firestore.collection('lendingEntries').snapshots().map((snapshot) {
//       return snapshot.docs
//           .map((doc) => LendingEntry.fromMap(doc.data(), doc.id))
//           .toList();
//     });
//   }
// }
