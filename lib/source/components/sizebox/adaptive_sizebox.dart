//
//  adaptive_sizebox.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveSizedBox extends StatelessWidget {
  // Properties
  final double? width;
  final double? height;
  final Widget? child;

  final bool applyAdaptiveScaleFactor;
  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  // Class Constructor
  const AdaptiveSizedBox({
    super.key,
    this.width,
    this.height,
    this.child,
    this.applyAdaptiveScaleFactor = true,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    double scaleFactor = 1.0;

    if (applyAdaptiveScaleFactor) {
      scaleFactor = Device.getScaleFactor(
          context, desktopFactor, tabletFactor, mobileFactor, smallMobileFactor);
    }

    Widget? transformChild;
    if (child != null) {
      transformChild = Transform.scale(scale: scaleFactor, child: child);
    }

    return SizedBox(
      height: height == null ? null : (height ?? 0) * scaleFactor,
      width: width == null ? null : (width ?? 0) * scaleFactor,
      child: transformChild,
    );
  }
}
