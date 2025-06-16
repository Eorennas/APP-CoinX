import 'package:flutter/material.dart';
import '../models/expense.dart';
import 'finance_screen.dart';

class AddExpenseScreen extends StatefulWidget {
  final VoidCallback onExpenseAdded;

  AddExpenseScreen({required this.onExpenseAdded});

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

    widget.onExpenseAdded(); // Notifica a tela principal para atualizar

    _descController.clear();
    _valueController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Gasto adicionado!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final larguraTela = MediaQuery.of(context).size.width;

    final inputDecoration = InputDecoration(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    );

    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(top: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: SizedBox(
                width: larguraTela * 0.75,
                child: TextField(
                  controller: _descController,
                  decoration:
                  inputDecoration.copyWith(labelText: 'Descrição'),
                  textInputAction: TextInputAction.next,
                ),
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: SizedBox(
                width: larguraTela * 0.75,
                child: TextField(
                  controller: _valueController,
                  decoration: inputDecoration.copyWith(labelText: 'Valor'),
                  keyboardType:
                  TextInputType.numberWithOptions(decimal: true),
                  textInputAction: TextInputAction.done,
                ),
              ),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: _salvarGasto,
              child: Text('Salvar Gasto'),
            ),
          ],
        ),
      ),
    );
  }
}
