import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/add_expense.dart';
import 'screens/finance_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(CoinXApp());
}

class CoinXApp extends StatefulWidget {
  @override
  _CoinXAppState createState() => _CoinXAppState();
}

class _CoinXAppState extends State<CoinXApp> {
  int _selectedIndex = 0;
  bool _initialized = false;
  ThemeMode _themeMode = ThemeMode.light;

  void _refreshFinanceScreen() {
    setState(() {});
  }

  void _toggleTheme() {
    setState(() {
      _themeMode =
      _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CoinX',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        primarySwatch: Colors.orange,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.orange,
      ),
      themeMode: _themeMode,
      home: _initialized
          ? Scaffold(
        appBar: AppBar(
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.currency_bitcoin, color: Colors.orange, size: 28),
              SizedBox(width: 8),
              Text(
                'CoinX',
                style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                ),
              ),
            ],
          ),
          centerTitle: true,
          actions: [
            IconButton(
              icon: Icon(
                _themeMode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              onPressed: _toggleTheme,
            )
          ],
        ),
        body: _selectedIndex == 0
            ? HomeScreen()
            : _selectedIndex == 1
            ? AddExpenseScreen(onExpenseAdded: _refreshFinanceScreen)
            : FinanceScreen(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.currency_bitcoin), label: 'Cotações'),
            BottomNavigationBarItem(
                icon: Icon(Icons.add_chart), label: 'Cadastrar Gasto'),
            BottomNavigationBarItem(
                icon: Icon(Icons.list), label: 'Finanças'),
          ],
        ),
      )
          : SplashScreen(onInitializationComplete: () {
        setState(() => _initialized = true);
      }),
    );
  }
}
