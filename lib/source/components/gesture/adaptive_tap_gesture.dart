//
//  adaptive_tap_gesture.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveTapGesture extends StatelessWidget {
  // Properties
  final Widget child;
  final VoidCallback onTap;
  final bool useInkWellOnWeb;
  final String? semanticsIdentifier;
  final bool isDisabled;

  // Class Constructor
  const AdaptiveTapGesture({
    super.key,
    required this.onTap,
    required this.child,
    this.useInkWellOnWeb = true,
    this.semanticsIdentifier,
    this.isDisabled = false,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    final opacity = isDisabled ? HelperConstant.disabledOpacity : HelperConstant.enabledOpacity;
    Widget widget = GestureDetector(onTap: isDisabled ? null : onTap, child: child);
    if (useInkWellOnWeb && Device.platformDesktopBrowser(context)) {
      final inkWellChild = InkWell(onTap: isDisabled ? null : onTap, child: child);
      widget = Material(color: Colors.transparent, child: inkWellChild);
    }

    return Semantics(
      label: semanticsIdentifier,
      excludeSemantics: true,
      child: Opacity(opacity: opacity, child: widget),
    );
  }
}
