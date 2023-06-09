import 'package:flutter/material.dart';
import 'package:petrol_ledger/core/provider/sale_data_provider.dart';
import 'package:petrol_ledger/repository/sale_data/sqlite_sale_data.dart';
import 'package:petrol_ledger/core/colors.dart';
import 'package:petrol_ledger/features/keypad/views/layouts/keypad_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    return ChangeNotifierProvider(
      lazy: false,
      create: (context) => SaleDataProvider(SQLiteSaleData()),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: 'wix',
        ),
        home: const KeypadScreen(),
      ),
    );
  }
}
