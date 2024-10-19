import 'package:finance/animation/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finance/bloc/trasnsection/transection_bloc.dart';
import 'package:finance/bloc/trasnsection/trasnscetion_state.dart';
import 'package:finance/bloc/trasnsection/transections_event.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/model/transactions/transections_model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getwidget/getwidget.dart';

class TransactionScreen extends StatefulWidget {
  final String shopId;

  const TransactionScreen({super.key, required this.shopId});

  @override
  // ignore: library_private_types_in_public_api
  _TransactionScreenState createState() => _TransactionScreenState();
}

class _TransactionScreenState extends State<TransactionScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TransactionBloc>(context)
        .add(LoadTransactions(widget.shopId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Appcolor.primary,
        title: Text(
          "Transactions",
          style: GoogleFonts.lora(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 25,
              color: Colors.black,
            ),
            onPressed: () {
              _showTransactionForm(context, widget.shopId);
            },
          ),
        ],
      ),
      body: BlocBuilder<TransactionBloc, TransactionState>(
        builder: (context, state) {
          if (state is TransactionLoading) {
            return const Center(child: LoadingScreen());
          } else if (state is TransactionLoaded) {
            final transactions = state.transactions;
            double grandTotal = transactions.fold(
              0.0,
              (sum, transaction) => sum + transaction.amount,
            );

            if (transactions.isEmpty) {
              return Center(
                child: Text(
                  'No transactions available',
                  style: GoogleFonts.lora(fontSize: 16),
                ),
              );
            }

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(12.0),
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return GFListTile(
                        padding: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 16.0),
                        title: Text(
                          transaction.description,
                          style: GoogleFonts.lora(fontSize: 16),
                        ),
                        subTitle: Text(
                          "Amount: Rs.${transaction.amount.toStringAsFixed(2)}",
                          style: GoogleFonts.lora(
                              fontSize: 14, color: Colors.grey[600]),
                        ),
                        icon: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: const Icon(Icons.edit, color: Colors.blue),
                              onPressed: () => _showTransactionForm(
                                  context, widget.shopId,
                                  transaction: transaction),
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                BlocProvider.of<TransactionBloc>(context).add(
                                    DeleteTransaction(
                                        widget.shopId, transaction.id));
                              },
                            ),
                          ],
                        ),
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(vertical: 5),
                      );
                    },
                  ),
                ),
                // Displaying the grand total
                Container(
                  padding: const EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey.shade300)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Grand Total:',
                        style: GoogleFonts.lora(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Rs.${grandTotal.toStringAsFixed(2)}',
                        style: GoogleFonts.lora(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Appcolor.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (state is TransactionError) {
            return Center(
              child: Text(
                state.message,
                style: GoogleFonts.lora(fontSize: 16, color: Colors.red),
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  void _showTransactionForm(BuildContext context, String shopId,
      {ShopTransaction? transaction}) {
    final formKey = GlobalKey<FormState>();
    String description = transaction?.description ?? '';
    double amount = transaction?.amount ?? 0.0;
    DateTime selectedDate = transaction?.date ?? DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            transaction == null ? 'Add Transaction' : 'Edit Transaction',
            style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  initialValue: description,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    labelStyle: GoogleFonts.lora(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) => description = value!,
                ),
                const SizedBox(height: 12),
                TextFormField(
                  initialValue: amount.toString(),
                  decoration: InputDecoration(
                    labelText: 'Amount',
                    labelStyle: GoogleFonts.lora(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an amount';
                    }
                    return null;
                  },
                  onSaved: (value) => amount = double.parse(value!),
                ),
                const SizedBox(height: 12),
                TextFormField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: 'Date',
                    hintText: "${selectedDate.toLocal()}".split(' ')[0],
                    labelStyle: GoogleFonts.lora(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: selectedDate,
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null && pickedDate != selectedDate) {
                      setState(() {
                        selectedDate = pickedDate;
                      });
                    }
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: GoogleFonts.lora(),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  formKey.currentState!.save();
                  if (transaction == null) {
                    BlocProvider.of<TransactionBloc>(context)
                        .add(AddTransaction(
                      shopId,
                      ShopTransaction(
                        id: '',
                        description: description,
                        amount: amount,
                        date: selectedDate,
                      ),
                    ));
                  } else {
                    BlocProvider.of<TransactionBloc>(context)
                        .add(EditTransaction(
                      shopId,
                      ShopTransaction(
                        id: transaction.id,
                        description: description,
                        amount: amount,
                        date: selectedDate,
                      ),
                    ));
                  }
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Appcolor.primary,
              ),
              child: Text(
                transaction == null ? 'Add' : 'Update',
                style: GoogleFonts.lora(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
