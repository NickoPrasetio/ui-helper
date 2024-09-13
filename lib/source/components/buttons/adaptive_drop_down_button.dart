//
//  adaptive_drop_down_button.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveDropDownButton extends StatelessWidget {
  // Properties
  final Widget child;
  final bool enabled;
  final List<PopupMenuEntry> items;
  final String? semanticsIdentifier;
  final Color backgroundColor;
  final Color backgroundTintColor;

  // Class Constructor
  const AdaptiveDropDownButton({
    super.key,
    required this.items,
    required this.child,
    this.semanticsIdentifier,
    this.enabled = true,
    this.backgroundColor = ColorPalette.white,
    this.backgroundTintColor = ColorPalette.transparent,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    return AdaptiveTapGesture(
      semanticsIdentifier: semanticsIdentifier,
      onTap: () {
        if (enabled) {
          _showDropdown(context);
        }
      },
      child: child,
    );
  }

  // Object Level Private Methods
  void _showDropdown(BuildContext context) {
    final button = context.findRenderObject() as RenderBox;
    final overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final RelativeRect position = RelativeRect.fromRect(
      Rect.fromPoints(
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
        button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
      ),
      Offset.zero & overlay.size,
    );

    showMenu(
      context: context,
      position: position,
      items: items,
      color: backgroundColor,
      surfaceTintColor: backgroundTintColor,
    );
  }
}
