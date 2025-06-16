import 'dart:async';
import 'package:flutter/material.dart';
import '../services/bitcoin_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, double>? _cotacoes;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _carregarCotacoes(); // carregar logo ao abrir
    _timer = Timer.periodic(Duration(seconds: 10), (_) => _carregarCotacoes()); // a cada 10s
  }

  Future<void> _carregarCotacoes() async {
    try {
      final valores = await BitcoinService.getMultiplasCotacoes();
      setState(() {
        _cotacoes = valores;
      });
    } catch (e) {
      print('Erro ao buscar cotações: $e');
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Widget _buildCard(String nome, double valor, IconData icon, Color cor) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, size: 32, color: cor),
        title: Text(
          nome,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'R\$ ${valor.toStringAsFixed(6)}',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_cotacoes == null) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView(
      children: [
        SizedBox(height: 16),
        Center(
          child: Text(
            'Cotações ao vivo',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        _buildCard('Bitcoin', _cotacoes!['Bitcoin']!, Icons.currency_bitcoin,
            Colors.orange),
        _buildCard('Ethereum', _cotacoes!['Ethereum']!, Icons.token,
            Colors.blue),
        _buildCard('Solana', _cotacoes!['Solana']!, Icons.monetization_on,
            Colors.green),
      ],
    );
  }
}
