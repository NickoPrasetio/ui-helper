//
//  adaptive_spinner.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter_ui_helper/source/constant/semantic_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveSpinner extends StatelessWidget {
  // Properties
  final String? semanticsIdentifier;
  final double dimension;

  // Class Constructor
  const AdaptiveSpinner({
    super.key,
    this.semanticsIdentifier = SemanticsConstant.spinner,
    this.dimension = 100,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    Widget widget = Center(
      child: SizedBox.square(
        dimension: dimension,
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ColorPalette.solidBlue),
        ),
      ),
    );

    if (Device.platformiOS(context)) {
      return const CupertinoActivityIndicator(radius: 32);
    }

    return Semantics(label: semanticsIdentifier, excludeSemantics: true, child: widget);
  }
}
