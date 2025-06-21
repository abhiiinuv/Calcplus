import 'package:flutter/material.dart';
import '../models/calculator_tab.dart';

class CurrencyCalculator extends StatefulWidget {
  final CalculatorTab tab;
  final Function(CalculatorTab) onTabUpdated;

  const CurrencyCalculator({
    super.key,
    required this.tab,
    required this.onTabUpdated,
  });

  @override
  State<CurrencyCalculator> createState() => _CurrencyCalculatorState();
}

class _CurrencyCalculatorState extends State<CurrencyCalculator> {
  final TextEditingController _amountController = TextEditingController();
  String _fromCurrency = 'USD';
  String _toCurrency = 'EUR';
  double _rate = 0.85; // USD to EUR rate

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _amountController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Amount',
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
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _fromCurrency,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: Colors.grey[900],
                  decoration: const InputDecoration(
                    labelText: 'From',
                    labelStyle: TextStyle(color: Colors.orange),
                  ),
                  items:
                      ['USD', 'EUR', 'GBP', 'JPY'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromCurrency = newValue!;
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: DropdownButtonFormField<String>(
                  value: _toCurrency,
                  style: const TextStyle(color: Colors.white),
                  dropdownColor: Colors.grey[900],
                  decoration: const InputDecoration(
                    labelText: 'To',
                    labelStyle: TextStyle(color: Colors.orange),
                  ),
                  items:
                      ['USD', 'EUR', 'GBP', 'JPY'].map((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _toCurrency = newValue!;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _convertCurrency,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Convert'),
          ),
        ],
      ),
    );
  }

  void _convertCurrency() {
    try {
      double amount = double.parse(_amountController.text);
      double convertedAmount = amount * _rate;

      List<String> newHistory = List.from(widget.tab.history);
      newHistory.add(
        '${amount.toStringAsFixed(2)} $_fromCurrency = ${convertedAmount.toStringAsFixed(2)} $_toCurrency',
      );

      widget.onTabUpdated(
        widget.tab.copyWith(
          currentExpression:
              '${convertedAmount.toStringAsFixed(2)} $_toCurrency',
          history: newHistory,
        ),
      );
    } catch (e) {
      // Handle errors
    }
  }
}
