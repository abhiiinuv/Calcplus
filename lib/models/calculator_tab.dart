import 'calculator_mode.dart';

class CalculatorTab {
  final String id;
  final String name;
  final CalculatorMode mode;
  final List<String> history;
  final String currentExpression;

  const CalculatorTab({
    required this.id,
    required this.name,
    required this.mode,
    required this.history,
    required this.currentExpression,
  });

  CalculatorTab copyWith({
    String? id,
    String? name,
    CalculatorMode? mode,
    List<String>? history,
    String? currentExpression,
  }) {
    return CalculatorTab(
      id: id ?? this.id,
      name: name ?? this.name,
      mode: mode ?? this.mode,
      history: history ?? this.history,
      currentExpression: currentExpression ?? this.currentExpression,
    );
  }
}
