import 'package:equatable/equatable.dart';

abstract class RashifalState extends Equatable {
  @override
  List<Object> get props => [];
}

class RashifalLoading extends RashifalState {}

class RashifalLoaded extends RashifalState {}

class RashifalError extends RashifalState {}