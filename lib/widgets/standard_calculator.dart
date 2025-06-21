import 'package:flutter/material.dart';
import 'dart:math';
import '../models/calculator_tab.dart';

class StandardCalculator extends StatelessWidget {
  final CalculatorTab tab;
  final Function(CalculatorTab) onTabUpdated;

  const StandardCalculator({
    super.key,
    required this.tab,
    required this.onTabUpdated,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: [
                _buildButton('C', Colors.red, () => _clear()),
                _buildButton('±', Colors.grey[700]!, () => _toggleSign()),
                _buildButton('%', Colors.grey[700]!, () => _percentage()),
                _buildButton('÷', Colors.orange, () => _addOperator('÷')),
                _buildButton('7', Colors.grey[800]!, () => _addNumber('7')),
                _buildButton('8', Colors.grey[800]!, () => _addNumber('8')),
                _buildButton('9', Colors.grey[800]!, () => _addNumber('9')),
                _buildButton('×', Colors.orange, () => _addOperator('×')),
                _buildButton('4', Colors.grey[800]!, () => _addNumber('4')),
                _buildButton('5', Colors.grey[800]!, () => _addNumber('5')),
                _buildButton('6', Colors.grey[800]!, () => _addNumber('6')),
                _buildButton('-', Colors.orange, () => _addOperator('-')),
                _buildButton('1', Colors.grey[800]!, () => _addNumber('1')),
                _buildButton('2', Colors.grey[800]!, () => _addNumber('2')),
                _buildButton('3', Colors.grey[800]!, () => _addNumber('3')),
                _buildButton('+', Colors.orange, () => _addOperator('+')),
                _buildButton('0', Colors.grey[800]!, () => _addNumber('0')),
                _buildButton('.', Colors.grey[800]!, () => _addDecimal()),
                _buildButton('=', Colors.orange, () => _calculate()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, Color color, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }

  void _addNumber(String number) {
    String newExpression = tab.currentExpression + number;
    onTabUpdated(tab.copyWith(currentExpression: newExpression));
  }

  void _addOperator(String operator) {
    if (tab.currentExpression.isNotEmpty) {
      String newExpression = tab.currentExpression + ' $operator ';
      onTabUpdated(tab.copyWith(currentExpression: newExpression));
    }
  }

  void _addDecimal() {
    if (!tab.currentExpression.contains('.')) {
      String newExpression = tab.currentExpression + '.';
      onTabUpdated(tab.copyWith(currentExpression: newExpression));
    }
  }

  void _clear() {
    onTabUpdated(tab.copyWith(currentExpression: '', history: []));
  }

  void _toggleSign() {
    if (tab.currentExpression.isNotEmpty) {
      double? number = double.tryParse(tab.currentExpression);
      if (number != null) {
        String newExpression = (-number).toString();
        onTabUpdated(tab.copyWith(currentExpression: newExpression));
      }
    }
  }

  void _percentage() {
    if (tab.currentExpression.isNotEmpty) {
      double? number = double.tryParse(tab.currentExpression);
      if (number != null) {
        String newExpression = (number / 100).toString();
        onTabUpdated(tab.copyWith(currentExpression: newExpression));
      }
    }
  }

  void _calculate() {
    if (tab.currentExpression.isNotEmpty) {
      try {
        String expression = tab.currentExpression
            .replaceAll('×', '*')
            .replaceAll('÷', '/');
        double result = _evaluateExpression(expression);

        List<String> newHistory = List.from(tab.history);
        newHistory.add(
          '${tab.currentExpression} = ${result.toStringAsFixed(2)}',
        );

        onTabUpdated(
          tab.copyWith(
            currentExpression: result.toStringAsFixed(2),
            history: newHistory,
          ),
        );
      } catch (e) {
        // Handle calculation errors
        onTabUpdated(tab.copyWith(currentExpression: 'Error'));
      }
    }
  }

  double _evaluateExpression(String expression) {
    // Simple expression evaluator for basic arithmetic
    List<String> tokens = expression.split(' ');
    if (tokens.length == 1) {
      return double.parse(tokens[0]);
    }

    double result = double.parse(tokens[0]);
    for (int i = 1; i < tokens.length; i += 2) {
      String operator = tokens[i];
      double operand = double.parse(tokens[i + 1]);

      switch (operator) {
        case '+':
          result += operand;
          break;
        case '-':
          result -= operand;
          break;
        case '*':
          result *= operand;
          break;
        case '/':
          if (operand == 0) throw Exception('Division by zero');
          result /= operand;
          break;
      }
    }
    return result;
  }
}
