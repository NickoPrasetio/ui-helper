//
//  uifont.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 25/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';

// =============== Enum to hold Font System  =============== //
enum UIFontSystem { bold, semiBold, regular, light }

final class UIFont {
  static const double h0 = 64.0;
  static const double h1 = 32.0;
  static const double h2 = 24.0;
  static const double h3 = 20.0;
  static const double h4 = 18.0;
  static const double h5 = 16.0;
  static const double h6 = 14.0;
  static const double h7 = 12.0;
  static const double h8 = 10.0;
  static const double h9 = 8.0;
  static const double h10 = 6.0;
  static const double h11 = 4.0;
  static const double h12 = 2.0;

  static FontWeight getFontWeightFrom(UIFontSystem fontSystem) {
    var fontWeight = FontWeight.w400;

    switch (fontSystem) {
      case UIFontSystem.bold:
        fontWeight = FontWeight.w700;
        break;
      case UIFontSystem.semiBold:
        fontWeight = FontWeight.w600;
        break;
      case UIFontSystem.regular:
        fontWeight = FontWeight.w400;
        break;
      case UIFontSystem.light:
        fontWeight = FontWeight.w300;
        break;
    }
    return fontWeight;
  }
}
