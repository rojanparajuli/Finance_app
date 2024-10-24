
import 'package:equatable/equatable.dart';
import 'package:finance/model/lending/lending_model.dart';

abstract class LendingEvent extends Equatable {
  const LendingEvent();
  @override
  List<Object> get props => [];
}

class AddLendingEvent extends LendingEvent {
  final String id;
  final String name;
  final double amount;
  final DateTime promisedDate;
  final DateTime returnDate;

  const AddLendingEvent({
    required this.id,
    required this.name,
    required this.amount,
    required this.promisedDate,
    required this.returnDate,
  });

  @override
  List<Object> get props => [id, name, amount, promisedDate, returnDate];
}

class EditLendingEvent extends LendingEvent {
  final String id;
  final Lending lending;

  const EditLendingEvent({required this.id, required this.lending});

  @override
  List<Object> get props => [id, lending];
}

class DeleteLendingEvent extends LendingEvent {
  final String id;

  DeleteLendingEvent(this.id);

  @override
  List<Object> get props => [id];
}

class LoadLendingsEvent extends LendingEvent {}
