import 'package:equatable/equatable.dart';

abstract class JokeEvent extends Equatable {
  const JokeEvent();

  @override
  List<Object> get props => [];
}

class LoadJokeOfTheDay extends JokeEvent {}
