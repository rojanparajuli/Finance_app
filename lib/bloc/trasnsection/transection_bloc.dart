import 'package:finance/bloc/trasnsection/transections_event.dart';
import 'package:finance/bloc/trasnsection/trasnscetion_state.dart';
import 'package:finance/model/transactions/transections_model.dart'; 
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TransactionBloc extends Bloc<TransactionEvent, TransactionState> {
  final FirebaseFirestore firestore;

  TransactionBloc(this.firestore) : super(TransactionLoading()) {
    on<LoadTransactions>(_onLoadTransactions);
    on<AddTransaction>(_onAddTransaction);
    on<EditTransaction>(_onEditTransaction);
    on<DeleteTransaction>(_onDeleteTransaction);
  }

  Future<void> _onLoadTransactions(
      LoadTransactions event, Emitter<TransactionState> emit) async {
    try {
      QuerySnapshot snapshot = await firestore
          .collection('shops')
          .doc(event.shopId)
          .collection('transactions')
          .get();
      List<ShopTransaction> transactions = snapshot.docs
          .map((doc) => ShopTransaction.fromFirestore(doc))
          .toList();
      emit(TransactionLoaded(transactions));
    } catch (e) {
      emit(TransactionError('Failed to load transactions.'));
    }
  }

  Future<void> _onAddTransaction(
      AddTransaction event, Emitter<TransactionState> emit) async {
    try {
      await firestore
          .collection('shops')
          .doc(event.shopId)
          .collection('transactions')
          .add(event.transaction.toMap());
      add(LoadTransactions(event.shopId));
    } catch (e) {
      emit(TransactionError('Failed to add transaction.'));
    }
  }

  Future<void> _onEditTransaction(
      EditTransaction event, Emitter<TransactionState> emit) async {
    try {
      await firestore
          .collection('shops')
          .doc(event.shopId)
          .collection('transactions')
          .doc(event.transaction.id)
          .update(event.transaction.toMap());
      add(LoadTransactions(event.shopId));
    } catch (e) {
      emit(TransactionError('Failed to edit transaction.'));
    }
  }

  Future<void> _onDeleteTransaction(
      DeleteTransaction event, Emitter<TransactionState> emit) async {
    try {
      await firestore
          .collection('shops')
          .doc(event.shopId)
          .collection('transactions')
          .doc(event.transactionId)
          .delete();
      add(LoadTransactions(event.shopId));
    } catch (e) {
      emit(TransactionError('Failed to delete transaction.'));
    }
  }
}
