import 'package:finance/bloc/calculator/calculator_bloc.dart';
import 'package:finance/bloc/calculator/calculator_event.dart';
import 'package:finance/constant/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget buildButtonRow(List<String> buttons, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8.0),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons.map((btnText) {
        return ElevatedButton(
          onPressed: () {
            final calculatorBloc = BlocProvider.of<CalculatorBloc>(context);
            if (btnText == 'C') {
              calculatorBloc.add(Clear());
            } else if (btnText == '=') {
              calculatorBloc.add(Calculate());
            } else if (['+', '-', 'x', '/'].contains(btnText)) {
              calculatorBloc.add(AddOperator(btnText));
            } else {
              calculatorBloc.add(AddNumber(btnText));
            }
          },
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.white, backgroundColor: Appcolor.primary, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40), 
            textStyle: const TextStyle(fontSize: 24),
          ),
          child: Text(btnText),
        );
      }).toList(),
    ),
  );
}
