import 'package:finance/bloc/calculator/calculator_bloc.dart';
import 'package:finance/bloc/calculator/calculator_state.dart';
import 'package:finance/constant/colors.dart';
import 'package:finance/screen/calculator/widget/calculator_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Calculator',
          style: GoogleFonts.lora(color: Colors.white),
        ),
        backgroundColor: Appcolor.primary,
        leading: GestureDetector(
          onTap:(){ Navigator.pop(context);},
            child: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
        )),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<CalculatorBloc, CalculatorState>(
                builder: (context, state) {
                  return Container(
                    padding: const EdgeInsets.all(24),
                    alignment: Alignment.bottomRight,
                    child: Card(
                      elevation: 4,
                      color: Appcolor.secondary, 
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          state is CalculatorInitial ? state.display : '0',
                          style: const TextStyle(
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            buildButtonRow(['7', '8', '9', '/'], context),
            buildButtonRow(['4', '5', '6', 'x'], context),
            buildButtonRow(['1', '2', '3', '-'], context),
            buildButtonRow(['0', 'C', '=', '+'], context),
          ],
        ),
      ),
    );
  }
}
