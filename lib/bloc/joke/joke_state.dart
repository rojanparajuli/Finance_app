import 'package:equatable/equatable.dart';

abstract class JokeState extends Equatable {
  const JokeState();

  @override
  List<Object> get props => [];
}

class JokeLoading extends JokeState {}

class JokeLoaded extends JokeState {
  final String joke;

  const JokeLoaded(this.joke);

  @override
  List<Object> get props => [joke];
}

class JokeError extends JokeState {
  final String message;

  const JokeError(this.message);

  @override
  List<Object> get props => [message];
}
