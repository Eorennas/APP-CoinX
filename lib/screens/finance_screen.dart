import 'package:flutter/material.dart';
import '../models/expense.dart';

class FinanceScreen extends StatefulWidget {
  static final List<Expense> expenses = [];

  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  double get _totalDoMes {
    final now = DateTime.now();
    return FinanceScreen.expenses
        .where((e) => e.date.month == now.month && e.date.year == now.year)
        .fold(0.0, (total, e) => total + e.value);
  }

  @override
  Widget build(BuildContext context) {
    if (FinanceScreen.expenses.isEmpty) {
      return Center(
        child: Text(
          'Nenhum gasto registrado',
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      itemCount: FinanceScreen.expenses.length + 1, // +1 para o rodapé
      itemBuilder: (context, index) {
        if (index < FinanceScreen.expenses.length) {
          final e = FinanceScreen.expenses[index];
          return Card(
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(Icons.money),
              title: Text(e.description),
              trailing: Text('R\$ ${e.value.toStringAsFixed(2)}'),
              subtitle: Text(e.date.toString().split('.')[0]),
            ),
          );
        } else {
          // Rodapé com o total do mês
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                'Total do mês: R\$ ${_totalDoMes.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange,
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
