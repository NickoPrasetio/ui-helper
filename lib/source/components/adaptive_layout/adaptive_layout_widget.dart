//
//  adaptive_layout_widget.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveLayoutWidget extends StatelessWidget {
  // Properties
  final Widget desktop;
  final Widget tablet;
  final Widget mobile;
  final Widget smallMobile;
  final bool addScrollViewToWebApp;

  // Class Constructor
  const AdaptiveLayoutWidget({
    super.key,
    required this.desktop,
    required this.tablet,
    required this.mobile,
    required this.smallMobile,
    this.addScrollViewToWebApp = false,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Widget? child;
        if (Device.isLargeScreen(context)) {
          child = desktop;
        } else if (Device.isMediumScreen(context)) {
          child = tablet;
        } else if (Device.isSmallScreen(context)) {
          child = mobile;
        } else {
          child = smallMobile;
        }

        return addScrollViewToWebApp ? AdaptiveScroll(child: child) : child;
      },
    );
  }
}
