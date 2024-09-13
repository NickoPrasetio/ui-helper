//
//  table_row.dart
//  Inspire
//
//  Created by Nicko Prasetio on 27/08/2024.
//  Copyright © 2024 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TableRowCustom extends StatelessWidget {
  final String text;
  final double width;
  final dynamic alignment;
  final bool isPrimaryData;
  final bool shouldShowBorder;
  final bool shouldBoldText;

  // Class Constructor
  const TableRowCustom(
      {super.key,
      this.text = "",
      this.width = 90,
      this.alignment = Alignment.centerLeft,
      this.isPrimaryData = false,
      this.shouldShowBorder = false,
      this.shouldBoldText = false});

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      decoration: shouldShowBorder
          ? const BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: ColorPalette.gray3, width: 1)))
          : null,
      width: width,
      padding: const EdgeInsets.only(top: 12, bottom: 12, right: 12),
      height: 50,
      child: _rowText(text,
          isPrimaryData: isPrimaryData, shouldBoldText: shouldBoldText),
    );
  }

  Widget _rowText(String text,
      {isPrimaryData = false, shouldBoldText = false}) {
    return AdaptiveText(
      overflow: TextOverflow.ellipsis,
      text: text,
      maxLines: 1,
      textAlign: TextAlign.left,
      color: isPrimaryData ? ColorPalette.peacockBlue : ColorPalette.gray2,
      fontSize: UIFont.h6,
      fontSystem: shouldBoldText ? UIFontSystem.semiBold : UIFontSystem.light,
      mobileFactor: 0.6,
      smallMobileFactor: 0.4,
    );
  }
}
