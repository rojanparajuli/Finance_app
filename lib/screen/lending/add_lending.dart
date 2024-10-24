import 'package:finance/bloc/lending/lending_bloc.dart';
import 'package:finance/bloc/lending/lending_event.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/model/lending/lending_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LendingAddPage extends StatefulWidget {
  final Lending? lending; // Optional parameter for editing

  const LendingAddPage({super.key, this.lending});

  @override
  // ignore: library_private_types_in_public_api
  _LendingAddPageState createState() => _LendingAddPageState();
}

class _LendingAddPageState extends State<LendingAddPage> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  double _amount = 0.0;
  DateTime _promisedDate = DateTime.now();
  DateTime _returnDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    if (widget.lending != null) {
      _name = widget.lending!.name;
      _amount = widget.lending!.amount;
      _promisedDate = widget.lending!.promisedDate;
      _returnDate = widget.lending!.returnDate;
    }
  }

  Future<void> _selectDate(BuildContext context, bool isPromisedDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isPromisedDate ? _promisedDate : _returnDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      if (isPromisedDate) {
        _promisedDate = picked;
      } else {
        _returnDate = picked;
      }
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
                decoration: InputDecoration(
                  labelText: 'Name',
                  labelStyle: GoogleFonts.lora(color: Appcolor.secondary),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolor.primary, width: 2.0),
                  ),
                ),
                initialValue: _name,
                onSaved: (value) => _name = value!,
                validator: (value) => value!.isEmpty ? 'Enter a name' : null,
                style: GoogleFonts.lora(),
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Amount',
                  labelStyle: GoogleFonts.lora(color: Appcolor.secondary),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Appcolor.primary, width: 2.0),
                  ),
                ),
                initialValue: _amount.toString(),
                keyboardType: TextInputType.number,
                onSaved: (value) => _amount = double.tryParse(value!) ?? 0.0,
                validator: (value) => value!.isEmpty ? 'Enter an amount' : null,
                style: GoogleFonts.lora(),
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'GivenDate',
                date: _promisedDate,
                onTap: () => _selectDate(context, true),
              ),
              const SizedBox(height: 16),
              _buildDateField(
                label: 'ReturnDate',
                date: _returnDate,
                onTap: () => _selectDate(context, false),
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
                      _formKey.currentState!.save();
                      final lending = Lending(
                        id: widget.lending?.id ?? DateTime.now().toString(),
                        name: _name,
                        amount: _amount,
                        promisedDate: _promisedDate,
                        returnDate: _returnDate,
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
                      style: GoogleFonts.lora(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDateField(
      {required String label,
      required DateTime date,
      required VoidCallback onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            '$label: ${date.toLocal()}'.split(' ')[0],
            style: GoogleFonts.lora(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: onTap,
          color: Appcolor.primary,
        ),
      ],
    );
  }
}
