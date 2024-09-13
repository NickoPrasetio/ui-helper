//
//  spinner_controller.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/source/components/spinner/adaptive_spinner.dart';
import 'package:flutter/material.dart';

class Spinner {
  static bool _isSpinnerShown = false;
  static void add(BuildContext context) {
    if (_isSpinnerShown) {
      return;
    }
    _isSpinnerShown = true;
    showDialog(
      context: context,
      builder: (context) => const PopScope(canPop: false, child: AdaptiveSpinner()),
      barrierDismissible: false,
    );
  }

  static void remove(BuildContext context) {
    if (_isSpinnerShown) {
      Navigator.pop(context);
      _isSpinnerShown = false;
    }
  }
}
