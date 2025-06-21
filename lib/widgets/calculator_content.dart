import 'package:flutter/material.dart';
import '../models/calculator_tab.dart';
import '../models/calculator_mode.dart';
import 'standard_calculator.dart';
import 'loan_calculator.dart';
import 'currency_calculator.dart';
import 'bmi_calculator.dart';
import 'unit_converter.dart';

class CalculatorContent extends StatelessWidget {
  final CalculatorTab tab;
  final Function(CalculatorTab) onTabUpdated;

  const CalculatorContent({
    super.key,
    required this.tab,
    required this.onTabUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Column(
        children: [
          // History display
          if (tab.history.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              color: Colors.grey[850],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children:
                    tab.history
                        .map(
                          (entry) => Text(
                            entry,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 16,
                            ),
                          ),
                        )
                        .toList(),
              ),
            ),

          // Current expression display
          if (tab.currentExpression.isNotEmpty)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Text(
                tab.currentExpression,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.right,
              ),
            ),

          // Calculator content based on mode
          Expanded(child: _buildCalculatorByMode()),
        ],
      ),
    );
  }

  Widget _buildCalculatorByMode() {
    switch (tab.mode) {
      case CalculatorMode.standard:
        return StandardCalculator(tab: tab, onTabUpdated: onTabUpdated);
      case CalculatorMode.loan:
        return LoanCalculator(tab: tab, onTabUpdated: onTabUpdated);
      case CalculatorMode.currency:
        return CurrencyCalculator(tab: tab, onTabUpdated: onTabUpdated);
      case CalculatorMode.bmi:
        return BMICalculator(tab: tab, onTabUpdated: onTabUpdated);
      case CalculatorMode.unit:
        return UnitConverter(tab: tab, onTabUpdated: onTabUpdated);
    }
  }
}
