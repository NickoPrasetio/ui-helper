//
//  regex_validation.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

enum RegexType {
  allowNumbersOnly,
  allowNumbersNotStartingWithZero,
  allowAlphanumericWithSpace,
  allowAlphanumericWithOutSpace,
  allowCharSpaceOnly,
  charAllowedInAddress,
  simpleEmail,
  email,
  password,
  allowNumbersAndOperators,
  nameWithSpecialChar,
}

class RegexExp {
  static const allowNumbersOnly = r'^[0-9]+$';
  static const allowNumbersNotStartingWithZero = r'^[1-9][0-9]*$';
  static const allowAmountNumbersNotStartingWithZero = r'^[1-9][0-9.,]*$';
  static const allowAlphanumericWithSpace = r'^[A-Z0-9a-z ]+$';
  static const allowAlphanumericWithOutSpace = r'^[A-Z0-9a-z]+$';
  static const allowCharSpaceOnly = r'^[a-zA-Z ]+$';
  static const charAllowedInAddress = r'^[A-Z0-9a-z.\\[\\],()/\\\\_ -]+$';
  static const simpleEmail = r'[A-Z0-9a-z._%+-]{3,}+@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}';
  static const email =
      r'^(?![@._%+-])(?!.*?[@._%+-][@._%+-])[A-Z0-9a-z._%+-]{3,}@[A-Za-z0-9.-]+\.[A-Za-z]{2,4}$';
  static const password = r'^(?=.*\d)(?=.*[A-Z])(?=.*\W).{10,15}$';
  static const allowNumbersAndOperators = r'^[0-9 *+-/]+$';
  static const nameWithSpecialChar = r'^[a-zA-Z][a-zA-Z-,. \’]*$';

  static String withLength({int min = 0, required int max}) {
    return '^.{$min,$max}\$';
  }

  static bool validateInput(String input, RegexType regexType) {
    return matchRegex(input, _getRegex(regexType));
  }

  static bool matchRegex(String input, String regexString) {
    return RegExp(regexString).hasMatch(input);
  }

  static String _getRegex(RegexType regexType) {
    String regexString;

    switch (regexType) {
      case RegexType.allowNumbersOnly:
        regexString = allowNumbersOnly;
        break;
      case RegexType.allowNumbersNotStartingWithZero:
        regexString = allowNumbersNotStartingWithZero;
        break;
      case RegexType.allowAlphanumericWithSpace:
        regexString = allowAlphanumericWithSpace;
        break;
      case RegexType.allowAlphanumericWithOutSpace:
        regexString = allowAlphanumericWithOutSpace;
        break;
      case RegexType.allowCharSpaceOnly:
        regexString = allowCharSpaceOnly;
        break;
      case RegexType.charAllowedInAddress:
        regexString = charAllowedInAddress;
        break;
      case RegexType.simpleEmail:
        regexString = simpleEmail;
        break;
      case RegexType.email:
        regexString = email;
        break;
      case RegexType.password:
        regexString = password;
        break;
      case RegexType.allowNumbersAndOperators:
        regexString = allowNumbersAndOperators;
        break;
      case RegexType.nameWithSpecialChar:
        regexString = nameWithSpecialChar;
        break;
    }

    return regexString;
  }
}
