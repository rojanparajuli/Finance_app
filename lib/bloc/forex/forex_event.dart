import 'package:equatable/equatable.dart';

abstract class ForexEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchForexRates extends ForexEvent {
  final String from;
  final String to;
  final int page;
  final int perPage;

  FetchForexRates({
    required this.from,
    required this.to,
    this.page = 1,
    this.perPage = 10,
  });

  @override
  List<Object> get props => [from, to, page, perPage];
}

class UpdateSearchQuery extends ForexEvent {
  final String query;

  UpdateSearchQuery(this.query);

  @override
  List<Object> get props => [query];
}

class LoadMoreForexRates extends ForexEvent {
  final String from;
  final String to;
  final int page;
  final int perPage;

  LoadMoreForexRates({
    required this.from,
    required this.to,
    required this.page,
    this.perPage = 10,
  });

  @override
  List<Object> get props => [from, to, page, perPage];
}
