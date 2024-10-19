import 'package:finance/model/transactions/transections_model.dart'; 

abstract class TransactionState {}

class TransactionLoading extends TransactionState {}

class TransactionLoaded extends TransactionState {
  final List<ShopTransaction> transactions; 
  TransactionLoaded(this.transactions);
}

class TransactionError extends TransactionState {
  final String message;

  TransactionError(this.message);
}
