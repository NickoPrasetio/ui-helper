//
//  uicolor.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 18/12/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';

extension UIColor on Color {
  static Color? fromHex(String hex) {
    if (hex.startsWith('#')) {
      hex = hex.substring(1);
    }

    if (hex.length == 8 || hex.length == 6) {
      int hexNumber = int.tryParse(hex, radix: 16) ?? 0;

      if (hex.length == 8) {
        double r = ((hexNumber & 0xff000000) >> 24) / 255;
        double g = ((hexNumber & 0x00ff0000) >> 16) / 255;
        double b = ((hexNumber & 0x0000ff00) >> 8) / 255;
        double a = (hexNumber & 0x000000ff) / 255;

        return Color.fromRGBO((r * 255).round(), (g * 255).round(), (b * 255).round(), a);
      } else {
        double r = ((hexNumber & 0xff0000) >> 16) / 255;
        double g = ((hexNumber & 0x00ff00) >> 8) / 255;
        double b = (hexNumber & 0x0000ff) / 255;

        return Color.fromRGBO((r * 255).round(), (g * 255).round(), (b * 255).round(), 1.0);
      }
    }

    return null;
  }
}
