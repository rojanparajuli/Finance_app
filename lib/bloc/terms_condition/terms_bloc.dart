import 'package:finance/bloc/terms_condition/terms_event.dart';
import 'package:finance/bloc/terms_condition/terms_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TermsBloc extends Bloc<TermsEvent, TermsState> {
  TermsBloc() : super(const TermsState(accepted: false)) {
    on<AcceptTermsEvent>((event, emit) {
      emit(const TermsState(accepted: true));
    });
    on<DeclineTermsEvent>((event, emit) {
      emit(const TermsState(accepted: false));
    });
  }
}
