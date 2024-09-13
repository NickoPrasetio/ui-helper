//
//  adaptive_title_value_text.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 23/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/source/components/text/adaptive_text.dart';

enum TitleValueTextDirection { vertical, horizontal }

class AdaptiveTitleValueText extends StatelessWidget {
  // Properties
  final IconData? icon;
  final AdaptiveText titleLabel;
  final AdaptiveText valueLabel;
  final CrossAxisAlignment crossAxisAlignment;
  final TitleValueTextDirection layoutDirection;

  // Class Constructor
  const AdaptiveTitleValueText({
    super.key,
    required this.titleLabel,
    required this.valueLabel,
    this.crossAxisAlignment = CrossAxisAlignment.start,
    this.layoutDirection = TitleValueTextDirection.vertical,
    this.icon,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    switch (layoutDirection) {
      case TitleValueTextDirection.vertical:
        return _buildVerticalLayout();
      case TitleValueTextDirection.horizontal:
        return _buildHorizontalLayout();
    }
  }

  // Object Level Private Methods
  Widget _buildVerticalLayout() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (icon != null) Icon(icon, size: titleLabel.fontSize + valueLabel.fontSize),
        const SizedBox(
          width: 4,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: crossAxisAlignment,
            children: [titleLabel, const SizedBox(width: 4), valueLabel],
          ),
        ),
      ],
    );
  }

  Widget _buildHorizontalLayout() {
    return Row(
      crossAxisAlignment: crossAxisAlignment,
      children: [titleLabel, const SizedBox(width: 8), valueLabel],
    );
  }
}
