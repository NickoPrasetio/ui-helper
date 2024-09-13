//
//  adaptive_nav_bar.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 17/11/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveAppBar extends StatelessWidget implements PreferredSizeWidget {
  // Properties
  final Color? color;
  final Widget? title;
  final double toolbarHeight;
  final List<Widget>? actions;
  final double opacity;
  final bool addShadow;

  @override
  Size get preferredSize => Size.fromHeight(toolbarHeight);

  // Class Constructor
  const AdaptiveAppBar({
    super.key,
    this.actions,
    this.color,
    this.toolbarHeight = 64,
    this.opacity = 1.0,
    this.addShadow = true,
    this.title,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Opacity(
        opacity: opacity,
        child: Container(
          height: toolbarHeight,
          decoration: BoxDecoration(
            boxShadow: addShadow ? [HelperConstant.getBoxShadow2()] : null,
            color: color,
          ),
          child: Stack(
            children: [
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: actions ?? [],
                ),
              ),
              if (title != null) ...{
                Center(child: title!),
              }
            ],
          ),
        ),
      ),
    );
  }
}
