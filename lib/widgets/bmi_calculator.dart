import 'package:flutter/material.dart';
import '../models/calculator_tab.dart';

class BMICalculator extends StatefulWidget {
  final CalculatorTab tab;
  final Function(CalculatorTab) onTabUpdated;

  const BMICalculator({
    super.key,
    required this.tab,
    required this.onTabUpdated,
  });

  @override
  State<BMICalculator> createState() => _BMICalculatorState();
}

class _BMICalculatorState extends State<BMICalculator> {
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          TextField(
            controller: _weightController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Weight (kg)',
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
            controller: _heightController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Height (m)',
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
            onPressed: _calculateBMI,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
            ),
            child: const Text('Calculate BMI'),
          ),
        ],
      ),
    );
  }

  void _calculateBMI() {
    try {
      double weight = double.parse(_weightController.text);
      double height = double.parse(_heightController.text);

      double bmi = weight / (height * height);
      String category = _getBMICategory(bmi);

      List<String> newHistory = List.from(widget.tab.history);
      newHistory.add(
        'BMI: ${weight}kg / (${height}m)² = ${bmi.toStringAsFixed(1)} ($category)',
      );

      widget.onTabUpdated(
        widget.tab.copyWith(
          currentExpression: 'BMI: ${bmi.toStringAsFixed(1)} ($category)',
          history: newHistory,
        ),
      );
    } catch (e) {
      // Handle errors
    }
  }

  String _getBMICategory(double bmi) {
    if (bmi < 18.5) return 'Underweight';
    if (bmi < 25) return 'Normal';
    if (bmi < 30) return 'Overweight';
    return 'Obese';
  }
}
