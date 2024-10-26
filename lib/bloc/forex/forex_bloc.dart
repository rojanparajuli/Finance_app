// forex_bloc.dart
import 'package:finance/constant/api.dart';
import 'package:finance/model/forex/forex_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'forex_event.dart';
import 'forex_state.dart';

class ForexBloc extends Bloc<ForexEvent, ForexState> {
  ForexBloc() : super(ForexInitial()) {
    on<FetchForexRates>(_onFetchForexRates);
  }

 Future<void> _onFetchForexRates(FetchForexRates event, Emitter<ForexState> emit) async {
  emit(ForexLoading());

  try {
    final response = await http.get(Uri.parse(
      '${Api.baseUrl}rates?from=${event.from}&to=${event.to}&page=${event.page}&per_page=${event.perPage}',
    ));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('API Response: $data'); 

      final forexResponse = ForexResponse.fromJson(data);
      print('Parsed Rates: ${forexResponse.rates}');

      emit(ForexLoaded(forexResponse.rates)); 
    } else {
      emit(ForexError('Failed to fetch forex rates. Status code: ${response.statusCode}'));
    }
  } catch (e) {
    emit(ForexError('An error occurred: $e'));
  }
}

}
