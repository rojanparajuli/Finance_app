import 'package:finance/model/transactions/transections_model.dart';

abstract class TransactionEvent {}

class LoadTransactions extends TransactionEvent {
  final String shopId;

  LoadTransactions(this.shopId);
}

class AddTransaction extends TransactionEvent {
  final String shopId;
  final ShopTransaction transaction;

  AddTransaction(this.shopId, this.transaction);
}

class EditTransaction extends TransactionEvent {
  final String shopId;
  final ShopTransaction transaction;

  EditTransaction(this.shopId, this.transaction);
}

class DeleteTransaction extends TransactionEvent {
  final String shopId;
  final String transactionId;

  DeleteTransaction(this.shopId, this.transactionId);
}

