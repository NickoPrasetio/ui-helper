//
//  regex.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'dart:convert';

import 'package:flutter_ui_helper/source/components/text/regex/regex_validation.dart';
import 'package:flutter_ui_helper/source/extension/enum_serialization.dart';

enum RegexOperation { stringExpression, calcExpression }

class Regex {
  static const valueKey = 'FormFieldValueForREGEX';
  final String expression;
  final bool showErrorOnValidRegex;
  final String errorMessage;
  final RegexOperation operation;
  bool expressionResult = false;

  Regex({
    required this.expression,
    required this.errorMessage,
    this.showErrorOnValidRegex = false,
    this.operation = RegexOperation.stringExpression,
  });

  factory Regex.fromJson(Map<String, dynamic> json) {
    return Regex(
      expression: json['expression'] as String? ?? '',
      errorMessage: json['errorMessage'] as String? ?? '',
      showErrorOnValidRegex: json['showErrorOnValidRegex'] as bool? ?? false,
      operation: EnumSerialization.fromJson(json['operation'], RegexOperation.values,
          defaultValue: RegexOperation.stringExpression),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'expression': expression,
      'errorMessage': errorMessage,
      'showErrorOnValidRegex': showErrorOnValidRegex,
      'operation': jsonEncode(operation.toJson())
    };
  }

  bool validate(String value) {
    bool result = false;

    if (operation == RegexOperation.stringExpression) {
      result = RegExp(expression).hasMatch(value);
    } else if (operation == RegexOperation.calcExpression) {
      bool isStrNumber = RegExp(RegexExp.allowNumbersOnly).hasMatch(value);

      if (isStrNumber) {
        final dict = {Regex.valueKey: double.parse(value)};
        result = Function.apply(RegExp(expression).hasMatch, [dict.values]);
      } else {
        result = true;
      }
    }

    if (showErrorOnValidRegex) {
      result = !result;
    }

    expressionResult = result;
    return result;
  }
}
