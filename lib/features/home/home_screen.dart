import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:petrol_ledger/features/home/bloc/home_bloc.dart';
import 'package:petrol_ledger/features/home/widgets/keypad_layout.dart';
import 'package:petrol_ledger/injection_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => $sl<HomeBloc>(),
      child: const Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: KeypadLayout(),
        ),
      ),
    );
  }
}
