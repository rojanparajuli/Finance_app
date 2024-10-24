import 'package:flutter_bloc/flutter_bloc.dart';
import 'calculator_event.dart';
import 'calculator_state.dart';

class CalculatorBloc extends Bloc<CalculatorEvent, CalculatorState> {
  String _currentInput = '';
  String _operator = '';
  late double _firstNumber;
  String _display = ''; // To hold the complete expression display

  CalculatorBloc() : super(CalculatorInitial(display: '0')) {
    on<AddNumber>(_onAddNumber);
    on<AddOperator>(_onAddOperator);
    on<Clear>(_onClear);
    on<Calculate>(_onCalculate);
  }

  void _onAddNumber(AddNumber event, Emitter<CalculatorState> emit) {
    _currentInput += event.number;
    _updateDisplay();
    emit(CalculatorInitial(display: _display));
  }

  void _onAddOperator(AddOperator event, Emitter<CalculatorState> emit) {
    if (_currentInput.isEmpty) return;

    // Save the first number and operator
    _firstNumber = double.tryParse(_currentInput) ?? 0.0;
    _operator = event.operator;

    // Update display to show the current input and operator
    _display = '$_firstNumber $_operator';
    emit(CalculatorInitial(display: _display));

    // Clear the input for the next number
    _currentInput = '';
  }

  void _onClear(Clear event, Emitter<CalculatorState> emit) {
    _currentInput = '';
    _firstNumber = 0;
    _operator = '';
    _display = '0';
    emit(CalculatorInitial(display: _display));
  }

  void _onCalculate(Calculate event, Emitter<CalculatorState> emit) {
    if (_currentInput.isEmpty || _operator.isEmpty) return;

    double secondNumber = double.tryParse(_currentInput) ?? 0.0;
    double result;

    switch (_operator) {
      case '+':
        result = _firstNumber + secondNumber;
        break;
      case '-':
        result = _firstNumber - secondNumber;
        break;
      case 'x':
        result = _firstNumber * secondNumber;
        break;
      case '/':
        if (secondNumber != 0) {
          result = _firstNumber / secondNumber;
        } else {
          emit(CalculatorInitial(display: 'Error'));
          return;
        }
        break;
      default:
        result = 0.0;
        break;
    }

    // Update the display to show the result and allow further calculations
    _display = '$result'; // Show the result
    _currentInput = result.toString(); // Prepare for the next input
    emit(CalculatorInitial(display: _display));
  }

  // Helper function to update display when adding numbers
  void _updateDisplay() {
    // If there's already an operator, show the current expression
    if (_operator.isNotEmpty) {
      _display = '$_firstNumber $_operator $_currentInput';
    } else {
      _display = _currentInput; // Only show current input if no operator yet
    }
  }
}
