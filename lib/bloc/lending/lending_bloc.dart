// lib/blocs/lending_bloc.dart

import 'package:finance/bloc/lending/lending_statee.dart';
import 'package:finance/model/lending/lending_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'lending_event.dart';

class LendingBloc extends Bloc<LendingEvent, LendingState> {
  final FirebaseFirestore firestore;

  LendingBloc(this.firestore) : super(LendingInitial()) {
    on<LoadLendingsEvent>((event, emit) async {
      emit(LendingLoading());
      try {
        QuerySnapshot querySnapshot = await firestore.collection('lendings').get();
        List<Lending> lendings = querySnapshot.docs
            .map((doc) => Lending.fromMap(doc.data() as Map<String, dynamic>)..id = doc.id)
            .toList();
        emit(LendingLoaded(lendings: lendings)); 
      } catch (e) {
        emit(LendingError(message: e.toString())); 
      }
    });

    on<AddLendingEvent>((event, emit) async {
      await firestore.collection('lendings').add({
        'name': event.name,
        'amount': event.amount,
        'promisedDate': event.promisedDate,
        'returnDate': event.returnDate,
      });
      add(LoadLendingsEvent()); 
    });

    on<EditLendingEvent>((event, emit) async {
      await firestore.collection('lendings').doc(event.lending.id).update({
        'name': event.lending.name,
        'amount': event.lending.amount,
        'promisedDate': event.lending.promisedDate,
        'returnDate': event.lending.returnDate,
      });
      add(LoadLendingsEvent()); 
    });

    on<DeleteLendingEvent>((event, emit) async {
      await firestore.collection('lendings').doc(event.id).delete();
      add(LoadLendingsEvent()); 
    });
  }
}
