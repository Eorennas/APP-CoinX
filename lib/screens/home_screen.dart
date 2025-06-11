import 'dart:async';
import 'package:flutter/material.dart';
import '../services/bitcoin_service.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final StreamController<Map<String, double>> _controller = StreamController();
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _carregarCotacoes(); // carrega imediatamente
    _timer = Timer.periodic(Duration(seconds: 60), (_) => _carregarCotacoes());
  }

  void _carregarCotacoes() async {
    try {
      final valores = await BitcoinService.getMultiplasCotacoes();
      _controller.add(valores);
    } catch (e) {
      print('ERRO: $e'); // <-- ADICIONE ISSO
      _controller.addError('Erro ao carregar cotações');
    }
  }


  @override
  void dispose() {
    _timer?.cancel();
    _controller.close();
    super.dispose();
  }

  Widget _buildCard(String nome, double valor, IconData icon, Color cor) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        leading: Icon(icon, size: 32, color: cor),
        title: Text(nome, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
        subtitle: Text('R\$ ${valor.toStringAsFixed(6)}', style: TextStyle(fontSize: 16)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Map<String, double>>(
      stream: _controller.stream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Erro ao carregar dados'));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Nenhuma cotação disponível'));
        }

        final data = snapshot.data!;

        return ListView(
          children: [
            SizedBox(height: 16),
            Center(
              child: Text(
                'Cotações ao Vivo',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            _buildCard('Bitcoin', data['Bitcoin']!, Icons.currency_bitcoin, Colors.orange),
            _buildCard('Ethereum', data['Ethereum']!, Icons.token, Colors.blue),
            _buildCard('Solana', data['Solana']!, Icons.monetization_on, Colors.green),
          ],
        );
      },
    );
  }
}
