import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart'; // Import for date formatting

import 'package:finance/bloc/lending/lending_bloc.dart';
import 'package:finance/bloc/lending/lending_event.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/model/lending/lending_model.dart';

class LendingAddPage extends StatefulWidget {
  final Lending? lending;

  const LendingAddPage({super.key, this.lending});

  @override
  _LendingAddPageState createState() => _LendingAddPageState();
}

class _LendingAddPageState extends State<LendingAddPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _amountController = TextEditingController();
  final ValueNotifier<DateTime> _promisedDate = ValueNotifier<DateTime>(DateTime.now());
  final ValueNotifier<DateTime> _returnDate = ValueNotifier<DateTime>(DateTime.now());

  @override
  void initState() {
    super.initState();
    if (widget.lending != null) {
      _nameController.text = widget.lending!.name;
      _amountController.text = widget.lending!.amount.toString();
      _promisedDate.value = widget.lending!.promisedDate;
      _returnDate.value = widget.lending!.returnDate;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _amountController.dispose();
    _promisedDate.dispose();
    _returnDate.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, ValueNotifier<DateTime> dateNotifier) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: dateNotifier.value,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      dateNotifier.value = picked;
      print('Selected date: $picked'); // Debugging line
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lending == null ? 'Add Lending' : 'Edit Lending',
          style: GoogleFonts.lora(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Appcolor.primary,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Lending Form',
                  style: GoogleFonts.lora(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: GoogleFonts.lora(color: Appcolor.secondary),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolor.primary, width: 2.0),
                  ),
                ),
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                style: GoogleFonts.lora(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _amountController,
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: GoogleFonts.lora(color: Appcolor.secondary),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolor.primary, width: 2.0),
                  ),
                ),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Enter an amount' : null,
                style: GoogleFonts.lora(),
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Given Date',
                dateNotifier: _promisedDate,
                onTap: () => _selectDate(context, _promisedDate),
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'Return Date',
                dateNotifier: _returnDate,
                onTap: () => _selectDate(context, _returnDate),
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                    backgroundColor: Appcolor.primary,
                    textStyle: GoogleFonts.lora(
                        fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final lending = Lending(
                        id: widget.lending?.id ?? DateTime.now().toString(),
                        name: _nameController.text,
                        amount: double.tryParse(_amountController.text) ?? 0.0,
                        promisedDate: _promisedDate.value,
                        returnDate: _returnDate.value,
                      );

                      if (widget.lending == null) {
                        context.read<LendingBloc>().add(AddLendingEvent(
                              id: lending.id,
                              name: lending.name,
                              amount: lending.amount,
                              promisedDate: lending.promisedDate,
                              returnDate: lending.returnDate,
                            ));
                      } else {
                        context.read<LendingBloc>().add(EditLendingEvent(
                              id: lending.id,
                              lending: lending,
                            ));
                      }
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    widget.lending == null ? 'Add Lending' : 'Edit Lending',
                    style: GoogleFonts.lora(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField({
    required String label,
    required ValueNotifier<DateTime> dateNotifier,
    required VoidCallback onTap,
  }) {
    return ValueListenableBuilder<DateTime>(
      valueListenable: dateNotifier,
      builder: (context, date, child) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade400),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              '$label: ${DateFormat('yyyy-MM-dd').format(date)}', // Format the date
              style: GoogleFonts.lora(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            trailing: IconButton(
              icon: const Icon(Icons.calendar_today),
              onPressed: onTap,
              color: Appcolor.primary,
            ),
          ),
        );
      },
    );
  }
}
