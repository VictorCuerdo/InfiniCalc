import 'dart:math';

import '../models/calculator_model.dart';

class CalculatorController {
  final CalculatorModel _model;

  CalculatorController(this._model);

  void input(String value) {
    // Modify currentInput based on the value
    _model.currentInput += value;
  }

  void calculate() {
    try {
      // Basic arithmetic calculations for the sake of this example
      final result = _evaluateExpression(_model.currentInput);
      _model.result = result.toString();
    } catch (e) {
      _model.result = 'Error';
    }
  }

  double _evaluateExpression(String expression) {
    // For now, let's do a very basic evaluation.
    // You'd want a more robust expression evaluator, possibly a package or library.
    if (expression.contains('+')) {
      var parts = expression.split('+');
      return double.parse(parts[0]) + double.parse(parts[1]);
    }
    // Continue for '-', '*', '/'

    // For trigonometric functions
    if (expression.contains('sin')) {
      var value = double.parse(expression.split('sin')[1]);
      return sin(value);
    }
    // Continue for 'cos', 'tan', etc.

    throw Exception('Invalid Operation');
  }

  void memoryClear() {
    _model.memory = null;
  }

  void memoryRecall() {
    if (_model.memory != null) {
      _model.currentInput = _model.memory.toString();
    }
  }

  void memoryAdd() {
    double? currentValue = double.tryParse(_model.currentInput);
    if (currentValue != null) {
      _model.memory = (_model.memory ?? 0) + currentValue;
    }
  }

  void memorySubtract() {
    double? currentValue = double.tryParse(_model.currentInput);
    if (currentValue != null) {
      _model.memory = (_model.memory ?? 0) - currentValue;
    }
  }

  void clear() {
    _model.currentInput = '';
    _model.result = '';
  }

  void backspace() {
    if (_model.currentInput.isNotEmpty) {
      _model.currentInput =
          _model.currentInput.substring(0, _model.currentInput.length - 1);
    }
  }

  // You'll add more methods here for memory functions, more operations, etc.
}
