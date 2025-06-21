import 'package:flutter/material.dart';
import '../models/calculator_tab.dart';
import 'dart:math';

class LoanCalculator extends StatefulWidget {
  final CalculatorTab tab;
  final Function(CalculatorTab) onTabUpdated;

  const LoanCalculator({
    super.key,
    required this.tab,
    required this.onTabUpdated,
  });

  @override
  State<LoanCalculator> createState() => _LoanCalculatorState();
}

class _LoanCalculatorState extends State<LoanCalculator> {
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _principalController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Principal Amount',
              labelStyle: TextStyle(color: Colors.orange),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _rateController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Annual Interest Rate (%)',
              labelStyle: TextStyle(color: Colors.orange),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _termController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Loan Term (Years)',
              labelStyle: TextStyle(color: Colors.orange),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.orange),
              ),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _calculateLoan,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Calculate Monthly Payment'),
          ),
        ],
      ),
    );
  }

  void _calculateLoan() {
    try {
      double principal = double.parse(_principalController.text);
      double rate =
          double.parse(_rateController.text) / 100 / 12; // Monthly rate
      int term = int.parse(_termController.text) * 12; // Monthly term

      double monthlyPayment =
          principal *
          (rate * pow(1 + rate, term)) /
          (pow(1 + rate, term) - 1);

      List<String> newHistory = List.from(widget.tab.history);
      newHistory.add(
        'Loan: \$${principal.toStringAsFixed(2)} at ${_rateController.text}% for ${_termController.text} years = \$${monthlyPayment.toStringAsFixed(2)}/month',
      );

      widget.onTabUpdated(
        widget.tab.copyWith(
          currentExpression:
              'Monthly Payment: \$${monthlyPayment.toStringAsFixed(2)}',
          history: newHistory,
        ),
      );
    } catch (e) {
      // Handle errors
    }
  }
}
