import 'package:bloc/bloc.dart';
import 'package:finance/bloc/rashifal/rashifal_event.dart';
import 'package:finance/bloc/rashifal/rashifal_state.dart';

class RashifalBloc extends Bloc<RashifalEvent, RashifalState> {
  bool _isLoaded = false;

  RashifalBloc() : super(RashifalLoading()) {
    on<LoadRashifal>((event, emit) async {
      if (_isLoaded) return;

      emit(RashifalLoading());
      try {
        await Future.delayed(const Duration(seconds: 1));
        emit(RashifalLoaded());
        _isLoaded = true; 
      } catch (_) {
        emit(RashifalError());
      }
    });
  }

  void resetLoading() {
    _isLoaded = false;
  }
}
