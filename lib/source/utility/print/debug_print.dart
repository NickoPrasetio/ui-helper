//
//  print.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 25/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/foundation.dart';

class DebugPrint {
  // Class Constructor
  DebugPrint(Object? object) {
    if (kDebugMode) {
      print(object);
    }
  }

  static void warning(String message) {
    if (kDebugMode) {
      print('[WARNING]: $message');
    }
  }

  static void log(String message) {
    if (kDebugMode) {
      print('[Logger]: $message');
    }
  }

  static void error(String message) {
    if (kDebugMode) {
      print('[ERROR]: $message');
    }
  }
}
