import 'package:equatable/equatable.dart';

class TermsState extends Equatable {
  final bool accepted;
  const TermsState({required this.accepted});

  @override
  List<Object> get props => [accepted];
}