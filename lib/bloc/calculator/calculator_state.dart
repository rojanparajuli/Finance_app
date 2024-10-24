abstract class CalculatorState {}

class CalculatorInitial extends CalculatorState {
  final String display;
  CalculatorInitial({this.display = '0'});
}
