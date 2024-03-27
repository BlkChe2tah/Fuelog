import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrol_ledger/core/design_system/colors.dart';
import 'package:petrol_ledger/core/data/repository/latest_sale_price_repository.dart';
import 'package:petrol_ledger/features/home/home_screen.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => di.$sl<LatestSalePriceRepository>(),
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          fontFamily: 'wix',
        ),
        home: FutureBuilder(
            future: di.$sl.allReady(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return const HomeScreen();
              } else {
                return const CircularProgressIndicator();
              }
            }),
      ),
    );
  }
}
