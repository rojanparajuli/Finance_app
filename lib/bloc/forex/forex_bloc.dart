import 'package:finance/constant/api.dart';
import 'package:finance/model/forex/forex_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'forex_event.dart';
import 'forex_state.dart';

class ForexBloc extends Bloc<ForexEvent, ForexState> {
  List<ForexRate> allRates = [];
  bool isLoadingMore = false;

  ForexBloc() : super(ForexInitial()) {
    on<FetchForexRates>(_onFetchForexRates);
    on<UpdateSearchQuery>(_onUpdateSearchQuery);
    on<LoadMoreForexRates>(_onLoadMoreForexRates);
  }

  Future<void> _onFetchForexRates(FetchForexRates event, Emitter<ForexState> emit) async {
    emit(ForexLoading());
    await _fetchRates(event.from, event.to, event.page, event.perPage, emit);
  }

  Future<void> _onLoadMoreForexRates(LoadMoreForexRates event, Emitter<ForexState> emit) async {
    if (isLoadingMore) return;
    isLoadingMore = true;
    await _fetchRates(event.from, event.to, event.page, event.perPage, emit, isLoadMore: true);
    isLoadingMore = false;
  }

  Future<void> _fetchRates(String from, String to, int page, int perPage, Emitter<ForexState> emit,
      {bool isLoadMore = false}) async {
    try {
      final response = await http.get(Uri.parse(
        '${Api.baseUrl}rates?from=$from&to=$to&page=$page&per_page=$perPage',
      ));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final forexResponse = ForexResponse.fromJson(data);

        if (isLoadMore) {
          allRates.addAll(forexResponse.rates);
        } else {
          allRates = forexResponse.rates;
        }
        
        emit(ForexLoaded(List.from(allRates))); 
      } else {
        emit(ForexError('Failed to fetch forex rates. Status code: ${response.statusCode}'));
      }
    } catch (e) {
      emit(ForexError('An error occurred: $e'));
    }
  }

  void _onUpdateSearchQuery(UpdateSearchQuery event, Emitter<ForexState> emit) {
    if (state is ForexLoaded) {
      final filteredRates = allRates.where((rate) {
        return rate.currency.toLowerCase().contains(event.query.toLowerCase());
      }).toList();

      emit(ForexLoaded(filteredRates));
    }
  }
}
