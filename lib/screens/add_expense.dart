import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'finance_screen.dart';

class AddExpenseScreen extends StatefulWidget {
  @override
  _AddExpenseScreenState createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends State<AddExpenseScreen> {
  final _descController = TextEditingController();
  final _valueController = TextEditingController();

  void _salvarGasto() {
    final desc = _descController.text.trim();
    final valor = double.tryParse(_valueController.text.trim());

    if (desc.isEmpty || valor == null || valor <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Preencha corretamente os campos')),
      );
      return;
    }

    FinanceScreen.expenses.add(
      Expense(description: desc, value: valor, date: DateTime.now()),
    );

    _descController.clear();
    _valueController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gasto adicionado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _descController,
            decoration: InputDecoration(labelText: 'Descrição'),
          ),
          TextField(
            controller: _valueController,
            decoration: InputDecoration(labelText: 'Valor'),
            keyboardType: TextInputType.numberWithOptions(decimal: true),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: _salvarGasto,
            child: Text('Salvar Gasto'),
          ),
        ],
      ),
    );
  }
}
