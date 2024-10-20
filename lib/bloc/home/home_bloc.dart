import 'dart:convert';
import 'package:finance/bloc/home/home_event.dart';
import 'package:finance/bloc/home/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart' show rootBundle;


class QuoteBloc extends Bloc<QuoteEvent, QuoteState> {
  final List<String> quotes = [];

  QuoteBloc() : super(QuoteInitial()) {
    on<LoadQuote>((event, emit) async {
      await _loadQuotes();
      if (quotes.isNotEmpty) {
        final index = DateTime.now().day % quotes.length; 
        emit(QuoteLoaded(quotes[index]));
      } else {
        emit(QuoteLoaded("No quotes available.")); 
      }
    });
  }

Future<void> _loadQuotes() async {
  try {
    final String response = await rootBundle.loadString('assets/quote.json');
    final data = json.decode(response);

    if (data['quotes'] is List) {
      quotes.addAll(data['quotes'].map<String>((q) => q['quote'] as String).toList());
      print("Quotes loaded: ${quotes.length}");
    } else {
      print("Quotes data not in expected format.");
    }
  } catch (e) {
    print("Error loading quotes: $e");
  }
}



}
