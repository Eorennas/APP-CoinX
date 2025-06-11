import 'dart:convert';
import 'package:http/http.dart' as http;

class BitcoinService {
  static Future<Map<String, double>> getMultiplasCotacoes() async {
    const taxaCambioUSDparaBRL = 5.45; // Valor estimado fixo (ou integre API de câmbio real)

    final urls = {
      'Bitcoin': 'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT',
      'Ethereum': 'https://api.binance.com/api/v3/ticker/price?symbol=ETHUSDT',
      'Solana': 'https://api.binance.com/api/v3/ticker/price?symbol=SOLUSDT',
    };

    Map<String, double> resultados = {};

    for (var entry in urls.entries) {
      final response = await http.get(Uri.parse(entry.value));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final precoUSD = double.parse(data['price']);
        resultados[entry.key] = precoUSD * taxaCambioUSDparaBRL;
      } else {
        throw Exception('Erro ao buscar ${entry.key}');
      }
    }

    return resultados;
  }
}
