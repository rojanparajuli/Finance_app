class ForexRate {
  final String currency;
  final double buy;
  final double sell;
  final int? unit;

  ForexRate({
    required this.currency,
    required this.buy,
    required this.sell,
    this.unit, 
  });

  factory ForexRate.fromJson(Map<String, dynamic> json) {
    final currencyData = json['currency'] ?? {};

    double parseToDouble(dynamic value) {
      if (value is double) return value;
      if (value is String) return double.tryParse(value) ?? 0.0;
      return 0.0;
    }

    return ForexRate(
      currency: currencyData['iso3'] ?? 'N/A',
      buy: parseToDouble(json['buy']),
      sell: parseToDouble(json['sell']),
      unit: currencyData['unit'], 
    );
  }

  @override
  String toString() {
    return 'ForexRate(currency: $currency, buy: $buy, sell: $sell, unit: ${unit ?? 'N/A'})'; 
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
