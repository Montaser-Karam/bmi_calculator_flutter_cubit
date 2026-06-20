import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'cubits/bmi_cubit/bmi_cubit.dart';
import 'views/bmi_input_view.dart';

void main() {
  runApp(const BmiCalculatorApp());
}

class BmiCalculatorApp extends StatelessWidget {
  const BmiCalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BmiCubit(),
      child: MaterialApp(
        title: 'BMI Calculator',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
        locale: const Locale('ar'),
        home: const BmiInputView(),
      ),
    );
  }
}
