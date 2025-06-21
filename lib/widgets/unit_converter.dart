import 'package:flutter/material.dart';
import '../models/calculator_tab.dart';

class UnitConverter extends StatefulWidget {
  final CalculatorTab tab;
  final Function(CalculatorTab) onTabUpdated;

  const UnitConverter({
    super.key,
    required this.tab,
    required this.onTabUpdated,
  });

  @override
  State<UnitConverter> createState() => _UnitConverterState();
}

class _UnitConverterState extends State<UnitConverter> {
  final TextEditingController _valueController = TextEditingController();
  String _conversionType = 'Length';
  String _fromUnit = 'Meters';
  String _toUnit = 'Feet';

  final Map<String, Map<String, double>> _conversions = {
    'Length': {
      'Meters to Feet': 3.28084,
      'Feet to Meters': 0.3048,
      'Meters to Inches': 39.3701,
      'Inches to Meters': 0.0254,
    },
    'Weight': {
      'Kilograms to Pounds': 2.20462,
      'Pounds to Kilograms': 0.453592,
      'Grams to Ounces': 0.035274,
      'Ounces to Grams': 28.3495,
    },
    'Temperature': {
      'Celsius to Fahrenheit': 1.8,
      'Fahrenheit to Celsius': 0.555556,
    },
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          DropdownButtonFormField<String>(
            value: _conversionType,
            style: const TextStyle(color: Colors.white),
            dropdownColor: Colors.grey[900],
            decoration: const InputDecoration(
              labelText: 'Conversion Type',
              labelStyle: TextStyle(color: Colors.orange),
            ),
            items:
                _conversions.keys.map((String value) {
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
                _conversionType = newValue!;
                _fromUnit =
                    _conversions[_conversionType]!.keys.first.split(' to ')[0];
                _toUnit =
                    _conversions[_conversionType]!.keys.first.split(' to ')[1];
              });
            },
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _valueController,
            style: const TextStyle(color: Colors.white),
            decoration: const InputDecoration(
              labelText: 'Value',
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
                child: Text(
                  'From: $_fromUnit',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
              const Icon(Icons.arrow_forward, color: Colors.orange),
              Expanded(
                child: Text(
                  'To: $_toUnit',
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _convert,
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

  void _convert() {
    try {
      double value = double.parse(_valueController.text);
      String conversionKey = '$_fromUnit to $_toUnit';
      double? conversionRate = _conversions[_conversionType]![conversionKey];

      if (conversionRate != null) {
        double convertedValue = value * conversionRate;

        List<String> newHistory = List.from(widget.tab.history);
        newHistory.add(
          '$value $_fromUnit = ${convertedValue.toStringAsFixed(2)} $_toUnit',
        );

        widget.onTabUpdated(
          widget.tab.copyWith(
            currentExpression: '${convertedValue.toStringAsFixed(2)} $_toUnit',
            history: newHistory,
          ),
        );
      }
    } catch (e) {
      // Handle errors
    }
  }
}
