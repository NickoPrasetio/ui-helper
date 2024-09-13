//
//  uitext_style.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 25/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';

final class UITextStyle {
  static TextStyle heading1 = TextStyle(
    fontSize: UIFont.h1,
    fontWeight: UIFont.getFontWeightFrom(UIFontSystem.bold),
  );

  static TextStyle heading2 = TextStyle(
    fontSize: UIFont.h2,
    fontWeight: UIFont.getFontWeightFrom(UIFontSystem.bold),
  );

  static TextStyle heading3 = TextStyle(
    fontSize: UIFont.h3,
    fontWeight: UIFont.getFontWeightFrom(UIFontSystem.bold),
  );

  static TextStyle subheading = TextStyle(
    fontSize: UIFont.h3,
    fontWeight: UIFont.getFontWeightFrom(UIFontSystem.regular),
  );

  static TextStyle body = TextStyle(
    fontSize: UIFont.h5,
    fontWeight: UIFont.getFontWeightFrom(UIFontSystem.regular),
  );

  static TextStyle caption = TextStyle(
    fontSize: UIFont.h7,
    fontWeight: UIFont.getFontWeightFrom(UIFontSystem.regular),
  );
}
