import 'package:equatable/equatable.dart';

abstract class TermsEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AcceptTermsEvent extends TermsEvent {}
class DeclineTermsEvent extends TermsEvent {}