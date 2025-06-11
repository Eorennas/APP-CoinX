import 'package:flutter/material.dart';
import '../models/expense.dart';

class FinanceScreen extends StatefulWidget {
  static final List<Expense> expenses = [];

  @override
  _FinanceScreenState createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: FinanceScreen.expenses.length,
      itemBuilder: (context, index) {
        final e = FinanceScreen.expenses[index];
        return Card(
          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            leading: Icon(Icons.money),
            title: Text(e.description),
            trailing: Text('R\$ ${e.value.toStringAsFixed(2)}'),
            subtitle: Text(e.date.toString().split('.')[0]), // Data e hora básica
          ),
        );
      },
    );
  }
}
