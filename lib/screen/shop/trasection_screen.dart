import 'package:finance/bloc/trasnsection/transection_bloc.dart';
import 'package:finance/bloc/trasnsection/trasnscetion_state.dart';
import 'package:finance/bloc/trasnsection/transections_event.dart';
import 'package:finance/model/transactions/transections_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionScreen extends StatelessWidget {
  final String shopId;

  const TransactionScreen({super.key, required this.shopId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Transactions"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Navigate to add transaction form
              _showTransactionForm(context, shopId);
            },
          ),
        ],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TransactionLoaded) {
            final transactions = state.transactions;
            if (transactions.isEmpty) {
              return const Center(child: Text('No transactions available'));
            }

            return ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  title: Text(transaction.description),
                  subtitle: Text(transaction.amount.toString()),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () =>
                            _showTransactionForm(context, shopId, transaction: transaction),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete),
                        onPressed: () {
                          BlocProvider.of<TransactionBloc>(context)
                              .add(DeleteTransaction(shopId, transaction.id));
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          } else if (state is TransactionError) {
            return Center(child: Text(state.message));
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  void _showTransactionForm(BuildContext context, String shopId, {ShopTransaction? transaction}) {
    final _formKey = GlobalKey<FormState>();
    String description = transaction?.description ?? '';
    double amount = transaction?.amount ?? 0.0;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(transaction == null ? 'Add Transaction' : 'Edit Transaction'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: description,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) => description = value!,
                ),
                TextFormField(
                  initialValue: amount.toString(),
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                  onSaved: (value) => amount = double.parse(value!),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _formKey.currentState!.save();
                  if (transaction == null) {
                    BlocProvider.of<TransactionBloc>(context).add(AddTransaction(
                      shopId,
                      ShopTransaction(
                        id: '',
                        description: description,
                        amount: amount,
                        date: DateTime.now(),
                      ),
                    ));
                  } else {
                    BlocProvider.of<TransactionBloc>(context).add(EditTransaction(
                      shopId,
                      ShopTransaction(
                        id: transaction.id,
                        description: description,
                        amount: amount,
                        date: transaction.date,
                      ),
                    ));
                  }
                  Navigator.pop(context);
                }
              },
              child:  Text(transaction == null ? 'Add' : 'Update'),
            ),
          ],
        );
      },
    );
  }
}
