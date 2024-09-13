//
//  helper_constant.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 17/11/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

enum BorderRadiusType { topLeft, topRight, bottomLeft, bottomRight, all }

final class HelperConstant {
  // =============== App Theme =============== //
  static const String fontFamily = 'AllianzNeo';

  // =============== Constant =============== //
  static const double enabledOpacity = 1;
  static const double disabledOpacity = 0.4;

  static const double textFontSpacing = 6.0;

  // =============== Border Radius =============== //

  static const double borderRadius = 8.0;

  static const double borderRadius0 = 64.0;
  static const double borderRadius1 = 32.0;
  static const double borderRadius2 = 24.0;
  static const double borderRadius3 = 20.0;
  static const double borderRadius4 = 18.0;
  static const double borderRadius5 = 16.0;
  static const double borderRadius6 = 14.0;
  static const double borderRadius7 = 12.0;
  static const double borderRadius8 = 10.0;
  static const double borderRadius9 = 8.0;
  static const double borderRadius10 = 6.0;
  static const double borderRadius11 = 4.0;

  // =============== Padding =============== //
  static const double padding0 = 64.0;
  static const double padding1 = 32.0;
  static const double padding2 = 24.0;
  static const double padding3 = 20.0;
  static const double padding4 = 18.0;
  static const double padding5 = 16.0;
  static const double padding6 = 14.0;
  static const double padding7 = 12.0;
  static const double padding8 = 10.0;
  static const double padding9 = 8.0;
  static const double padding10 = 6.0;
  static const double padding11 = 4.0;

  // =============== Images =============== //
  static const String path = 'packages/flutter_ui_helper/assets/images';

  static const signaturePlaceHolderEN = '$path/tapHereEN.png';
  static const signaturePlaceHolderID = '$path/tapHereID.png';

  // =============== BoxDecoration =============== //

  static BoxDecoration getBorderBoxDecoration({
    Color bgColor = ColorPalette.whiteBGColor,
    double cornerRadius = 12.0,
    List<BorderRadiusType>? borderRadiusTypes,
    Color borderColor = ColorPalette.gray3,
    double width = 1.0,
    List<BoxShadow>? shadow,
  }) {
    BorderRadiusGeometry borderRadius = BorderRadius.circular(cornerRadius);
    if (borderRadiusTypes != null && borderRadiusTypes.isNotEmpty) {
      BorderRadius topLeftRadius = BorderRadius.circular(0);
      BorderRadius topRightRadius = BorderRadius.circular(0);
      BorderRadius bottomLeftRadius = BorderRadius.circular(0);
      BorderRadius bottomRightRadius = BorderRadius.circular(0);
      Radius radius = Radius.circular(cornerRadius);

      for (var type in borderRadiusTypes) {
        switch (type) {
          case BorderRadiusType.topLeft:
            topLeftRadius = BorderRadius.only(topLeft: radius);
            break;
          case BorderRadiusType.topRight:
            topRightRadius = BorderRadius.only(topRight: radius);
            break;
          case BorderRadiusType.bottomLeft:
            bottomLeftRadius = BorderRadius.only(bottomLeft: radius);
            break;
          case BorderRadiusType.bottomRight:
            bottomRightRadius = BorderRadius.only(bottomRight: radius);
            break;
          default:
            topLeftRadius = BorderRadius.only(topLeft: radius);
            topRightRadius = BorderRadius.only(topRight: radius);
            bottomLeftRadius = BorderRadius.only(bottomLeft: radius);
            bottomRightRadius = BorderRadius.only(bottomRight: radius);
            break;
        }
      }

      borderRadius = BorderRadius.only(
        topLeft: topLeftRadius.topLeft,
        topRight: topRightRadius.topRight,
        bottomLeft: bottomLeftRadius.bottomLeft,
        bottomRight: bottomRightRadius.bottomRight,
      );
    }
    return BoxDecoration(
      color: bgColor,
      borderRadius: borderRadius,
      boxShadow: shadow,
      border: Border.all(color: borderColor, width: width),
    );
  }

  static BoxShadow getBoxShadow() {
    return const BoxShadow(
      color: ColorPalette.borderColor,
      blurRadius: 5.0,
      spreadRadius: 2.0,
      offset: Offset(0, 2),
    );
  }

  static BoxShadow getBoxShadow2() {
    return const BoxShadow(
      color: ColorPalette.borderColor,
      spreadRadius: 1.0,
      offset: Offset(0, 1),
    );
  }

  static Border getBoxBorder() {
    return const Border(
      top: BorderSide(
        color: ColorPalette.borderColor,
        width: 1.0,
      ),
    );
  }

  // =============== Text Alignment =============== //
  static TextAlign getTextAlignFrom(UITextAlignment align) {
    switch (align) {
      case UITextAlignment.left:
        return TextAlign.left;
      case UITextAlignment.center:
        return TextAlign.center;
      case UITextAlignment.right:
        return TextAlign.right;
      case UITextAlignment.justified:
        return TextAlign.justify;
      case UITextAlignment.start:
        return TextAlign.start;
      case UITextAlignment.end:
        return TextAlign.end;
      default:
        throw ArgumentError('Unknown raw value: $align');
    }
  }
}
