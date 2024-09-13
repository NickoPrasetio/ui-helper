//
//  adaptive_notification_button.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 17/11/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveNotificationButton extends StatelessWidget {
  // Properties
  final String? semanticsIdentifier;

  final Color color;
  final TextAlign textAlign;
  final double fontSize;
  final UIFontSystem fontSystem;

  // Class Constructor
  const AdaptiveNotificationButton({
    super.key,
    this.semanticsIdentifier,
    this.color = ColorPalette.white,
    this.textAlign = TextAlign.center,
    this.fontSize = UIFont.h8,
    this.fontSystem = UIFontSystem.bold,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 32,
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          AdaptiveTapGesture(
            semanticsIdentifier: semanticsIdentifier,
            onTap: () {},
            child: const Icon(
              Icons.notifications_outlined,
              color: ColorPalette.solidBlue,
              size: 24,
            ),
          ),
          Positioned(
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                color: Colors.red,
                borderRadius: BorderRadius.circular(8),
              ),
              constraints: const BoxConstraints(
                minWidth: 16,
                minHeight: 16,
              ),
              child: AdaptiveText(
                text: '3',
                color: color,
                textAlign: textAlign,
                fontSize: fontSize,
                fontSystem: fontSystem,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
