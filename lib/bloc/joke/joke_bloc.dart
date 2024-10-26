import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'joke_event.dart';
import 'joke_state.dart';

class JokeBloc extends Bloc<JokeEvent, JokeState> {
  JokeBloc() : super(JokeLoading()) {
    on<LoadJokeOfTheDay>(_onLoadJokeOfTheDay);
  }

  Future<void> _onLoadJokeOfTheDay(LoadJokeOfTheDay event, Emitter<JokeState> emit) async {
    try {
      emit(JokeLoading());

      final String response = await rootBundle.loadString('assets/joke.json');
      final data = json.decode(response);

      DateTime now = DateTime.now();
      int dayOfYear = now.difference(DateTime(now.year, 1, 1)).inDays + 1;

      int jokeIndex = dayOfYear % (data['jokes'].length as int);
      String dailyJoke = data['jokes'][jokeIndex]['text'];

      emit(JokeLoaded(dailyJoke));
    } catch (e) {
      emit(JokeError("Failed to load the joke of the day"));
    }
  }
}
