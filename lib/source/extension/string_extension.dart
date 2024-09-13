/*
  string_extension.dart
  
  Created by GABRIELSORE on 14/06/24.
  Copyright © 2024 Allianz. All rights reserved.
*/

extension StringExtensions on String {
  bool equalIgnoreCase(String secondString) => toLowerCase() == (secondString.toLowerCase());

  bool containsIgnoreCase(String secondString) =>
      toLowerCase().contains(secondString.toLowerCase());
}
