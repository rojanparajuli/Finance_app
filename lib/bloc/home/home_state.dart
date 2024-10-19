abstract class QuoteState {}

class QuoteInitial extends QuoteState {}

class QuoteLoaded extends QuoteState {
  final String quote;

  QuoteLoaded(this.quote);
}
