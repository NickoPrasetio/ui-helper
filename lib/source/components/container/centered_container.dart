//
//  centered_container.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/12/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class CenteredContainer extends StatelessWidget {
  // Properties
  final Widget child;
  final double maxWidth;
  final double minHeight;
  final double padding;
  final bool addScroll;

  // Class Constructor
  const CenteredContainer({
    super.key,
    required this.child,
    required this.maxWidth,
    this.minHeight = 0,
    this.padding = HelperConstant.padding1,
    this.addScroll = true,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    if (addScroll) {
      return Align(
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: maxWidth + padding * 2, minHeight: minHeight),
            child: Container(
              margin: EdgeInsets.only(left: padding, right: padding),
              alignment: Alignment.topCenter,
              child: child,
            ),
          ),
        ),
      );
    }

    return Align(
      alignment: Alignment.topCenter,
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth + padding * 2, minHeight: minHeight),
        child: Container(
          margin: EdgeInsets.only(left: padding, right: padding),
          alignment: Alignment.topCenter,
          child: child,
        ),
      ),
    );
  }
}
