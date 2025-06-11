import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_expense.dart';
import 'screens/finance_screen.dart';

void main() {
  runApp(CoinXApp());
}

class CoinXApp extends StatefulWidget {
  @override
  _CoinXAppState createState() => _CoinXAppState();
}

class _CoinXAppState extends State<CoinXApp> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    AddExpenseScreen(),
    FinanceScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinX',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('CoinX'),
          centerTitle: true,
        ),
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) => setState(() => _selectedIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.currency_bitcoin), label: 'Cotações'),
            BottomNavigationBarItem(icon: Icon(Icons.add_chart), label: 'Cadastrar Gasto'),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Finanças'),
          ],
        ),
      ),
    );
  }
}
