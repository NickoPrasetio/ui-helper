//
//  adaptive_scroll.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

class AdaptiveScroll extends StatelessWidget {
  // Properties
  final Widget child;
  final String? semanticsIdentifier;

  // Class Constructor
  const AdaptiveScroll({
    super.key,
    required this.child,
    this.semanticsIdentifier,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    Widget widget = SingleChildScrollView(child: child);
    if (!Device.isBrowser) {
      widget = child;
    }

    return Semantics(label: semanticsIdentifier, excludeSemantics: true, child: widget);
  }
}
