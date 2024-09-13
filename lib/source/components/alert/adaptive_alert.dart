//
//  adaptive_alert.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveAlert extends StatelessWidget {
  // Properties
  final String title;
  final String message;
  final List<Widget> actions;
  final String? semanticsIdentifier;

  // Class Constructor
  const AdaptiveAlert({
    super.key,
    required this.title,
    required this.message,
    required this.actions,
    this.semanticsIdentifier,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    Widget alertDialog = AlertDialog(
      title: AdaptiveText(text: title, fontSize: UIFont.h5, fontSystem: UIFontSystem.bold),
      content: AdaptiveText(
        text: message,
        textAlign: TextAlign.left,
        fontSize: UIFont.h5,
        fontSystem: UIFontSystem.regular,
      ),
      actions: actions,
    );

    if (Device.platformiOS(context)) {
      alertDialog = CupertinoAlertDialog(
        title: AdaptiveText(
          text: title,
          textAlign: TextAlign.center,
          fontSize: UIFont.h5,
          fontSystem: UIFontSystem.bold,
        ),
        content: AdaptiveText(
          text: message,
          textAlign: TextAlign.center,
          fontSize: UIFont.h5,
          fontSystem: UIFontSystem.regular,
        ),
        actions: actions,
      );
    }

    return Semantics(label: semanticsIdentifier, excludeSemantics: true, child: alertDialog);
  }
}
