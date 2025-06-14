import 'dart:convert';

import 'package:http/http.dart' as http;

  Future<double> _calculateIndex(List<dynamic> trades) async {    
    int yesCount = 0, noCount = 0;

    for (final trade in trades) {
      final count = (trade['count'] as num).toInt();
      final takerSide = trade['taker_side'];

      if (takerSide == 'yes') {
        yesCount += count;
      } else if (takerSide == 'no') {
        noCount += count;
      }
    }

    final total = yesCount + noCount;
    if (total == 0) return 50;

    return (yesCount / total) * 100;
  }

Future<double> fetchBitcoimData() async {
  try {
    final response = await http.get(
      Uri.parse(
        'https://api.elections.kalshi.com/v1/social/trades?market_ticker=KXBTCMAXY-25-DEC31-124999.99&page_size=1000',
      ),
    );

    final json = jsonDecode(response.body);

    return _calculateIndex(json['trades']);
  } catch (e) {
    rethrow;
  }
}

Future<double> fetchEggPrices() async {
  try {
    final response = await http.get(
      Uri.parse(
        'https://api.elections.kalshi.com/v1/social/trades?series_ticker=KXEGGS&page_size=1000',
      ),
    );

    final json = jsonDecode(response.body);

    return _calculateIndex(json['trades']);
  } catch (e) {
    rethrow;
  }
}

Future<double> fetchRecession() async {
  try {
    final response = await http.get(
      Uri.parse(
        'https://api.elections.kalshi.com/v1/social/trades?series_ticker=KXRECSSNBER&page_size=1000',
      ),
    );

    final json = jsonDecode(response.body);

    return _calculateIndex(json['trades']);
  } catch (e) {
    rethrow;
  }
}



Future<double> fetchInx() async {
  try {
    final response = await http.get(
      Uri.parse(
        'https://api.elections.kalshi.com/v1/social/trades?series_ticker=KXINXHIGH&page_size=1000',
      ),
    );

    final json = jsonDecode(response.body);

    return _calculateIndex(json['trades']);
  } catch (e) {
    rethrow;
  }
}
