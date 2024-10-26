import 'package:equatable/equatable.dart';
import 'package:finance/model/forex/forex_model.dart';

abstract class ForexState extends Equatable {
  @override
  List<Object> get props => [];
}

class ForexInitial extends ForexState {}

class ForexLoading extends ForexState {}

class ForexLoaded extends ForexState {
  final List<ForexRate> rates;

  ForexLoaded(this.rates);

  @override
  List<Object> get props => [rates];
}

class ForexError extends ForexState {
  final String message;

  ForexError(this.message);

  @override
  List<Object> get props => [message];
}
