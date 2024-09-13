//
//  adaptive_back_button.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveBackButton extends StatelessWidget {
  // Properties
  final String title;
  final String? semanticsIdentifier;

  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final UIFontSystem fontSystem;

  final double desktopFactor;
  final double tabletFactor;
  final double mobileFactor;
  final double smallMobileFactor;

  // Class Constructor
  const AdaptiveBackButton({
    super.key,
    required this.title,
    this.semanticsIdentifier,
    this.color = ColorPalette.blue,
    this.textAlign = TextAlign.left,
    this.fontSize = UIFont.h5,
    this.fontSystem = UIFontSystem.bold,
    this.desktopFactor = 1.0,
    this.tabletFactor = 1.0,
    this.mobileFactor = 1.0,
    this.smallMobileFactor = 1.0,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    if (Device.isBrowser) {
      return const EmptyWidget();
    }

    final mobileLayout = _mobileLayout(context);

    return AdaptiveLayoutWidget(
      desktop: _allOtherLayout(context),
      tablet: _allOtherLayout(context),
      mobile: mobileLayout,
      smallMobile: mobileLayout,
    );
  }

  Widget _mobileLayout(BuildContext context) {
    return AdaptiveTapGesture(
      semanticsIdentifier: semanticsIdentifier,
      child: Row(
        children: [
          Icon(Icons.arrow_back_ios_outlined, color: color),
        ],
      ),
      onTap: () {
        Navigator.pop(context); // Navigate back
      },
    );
  }

  Widget _allOtherLayout(BuildContext context) {
    return AdaptiveTapGesture(
      semanticsIdentifier: semanticsIdentifier,
      child: Row(
        children: [
          Icon(Icons.arrow_back, color: color),
          const SizedBox(width: 10),
          AdaptiveText(
            text: title,
            fontSize: UIFont.h5,
            fontSystem: UIFontSystem.bold,
            color: color,
          )
        ],
      ),
      onTap: () {
        Navigator.pop(context); // Navigate back
      },
    );
  }
}
