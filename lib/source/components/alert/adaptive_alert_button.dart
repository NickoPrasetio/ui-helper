//
//  adaptive_alert_button.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAlertButton extends StatelessWidget {
  // Properties
  final Widget child;
  final VoidCallback onPressed;
  final String? semanticsIdentifier;

  // Class Constructor
  const AdaptiveAlertButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.semanticsIdentifier,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    Widget button = TextButton(onPressed: onPressed, child: child);
    if (Device.platformiOS(context)) {
      button = CupertinoDialogAction(onPressed: onPressed, child: child);
    }

    return Semantics(label: semanticsIdentifier, excludeSemantics: true, child: button);
  }
}
