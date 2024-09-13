//
//  adaptive_scale.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveScale extends StatelessWidget {
  // Properties
  final Widget child;
  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  // Class Constructor
  const AdaptiveScale({
    super.key,
    required this.child,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    double scaleFactor = Device.getScaleFactor(
        context, desktopFactor, tabletFactor, mobileFactor, smallMobileFactor);

    return Transform.scale(scale: scaleFactor, child: child);
  }
}
