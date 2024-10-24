
import 'package:finance/model/lending/lending_model.dart';

abstract class LendingState {}

class LendingInitial extends LendingState {}

class LendingLoading extends LendingState {}

class LendingLoaded extends LendingState {
  final List<Lending> lendings;

  LendingLoaded({required this.lendings});
}

class LendingError extends LendingState {
  final String message;

  LendingError({required this.message});
}
