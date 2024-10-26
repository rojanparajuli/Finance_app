class ForexRate {
  final String currency;
  final double buy;
  final double sell;

  ForexRate({
    required this.currency,
    required this.buy,
    required this.sell,
  });

  factory ForexRate.fromJson(Map<String, dynamic> json) {
    final currencyData = json['currency'] ?? {};
    return ForexRate(
      currency: currencyData['iso3'] ?? 'N/A',  // Ensure 'iso3' is used here
      buy: (json['buy'] ?? 0).toDouble(),
      sell: (json['sell'] ?? 0).toDouble(),
    );
  }
}


class ForexResponse {
  final List<ForexRate> rates;

  ForexResponse({required this.rates});

  factory ForexResponse.fromJson(Map<String, dynamic> json) {
    final payload = json['data']?['payload'] ?? [];
    List<ForexRate> rates = [];

    for (var item in payload) {
      final ratesData = item['rates'] ?? [];
      rates.addAll((ratesData as List)
          .map((rate) => ForexRate.fromJson(rate))
          .toList());
    }

    return ForexResponse(rates: rates);
  }
}
