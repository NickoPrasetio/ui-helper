//
//  adaptive_app_bar_menu_button.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 17/11/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveAppBarMenuButton extends StatelessWidget {
  // Properties
  final Color color;
  final VoidCallback onTap;
  final String? semanticsIdentifier;

  // Class Constructor
  const AdaptiveAppBarMenuButton({
    super.key,
    required this.onTap,
    this.color = ColorPalette.gray2,
    this.semanticsIdentifier,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    return AdaptiveTapGesture(
      semanticsIdentifier: semanticsIdentifier,
      onTap: onTap,
      child: Icon(Icons.menu, color: color),
    );
  }
}
