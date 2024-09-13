//
//  color_palette.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 25/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/source/extension/uicolor.dart';
import 'package:flutter/material.dart';

final class ColorPalette {
  static const whiteHexCode = 'FFFFFF';
  static const blueHexCode = '017AB2';
  static const peacockBlueHexCode = '006192';
  static const frenchBlueHexCode = '007AB3';
  static const richElectricBlueHexCode = '0094D9';
  static const solidBlueHexCode = '00468A';
  static const tuftsBlueHexCode = '496EBD';
  static const blackHexCode = '001B3F';
  static const redHexCode = 'D11A38';
  static const grayHexCode = 'F2F2F2';
  static const gray2HexCode = '414141';
  static const gray3HexCode = 'D9D9D9';
  static const gray4HexCode = 'F5F5F5';
  static const gray5HexCode = 'EDF0F7';
  static const gray6HexCode = 'C9D1E2';
  static const gray7HexCode = '9E9E9E';
  static const lightGreenHexCode = 'EFF6EE';
  static const charcoalGreyHexCode = '414141';
  static const lemonGrassHexCode = '999999';
  static const bluishCyanHexCode = 'F1F9FA';
  static const silverHexCode = 'C2C2C2';
  static const wildSandHexCode = 'F4F4F4';
  static const codGrayHexCode = '1E1E1E';

  // Common
  static const Color transparent = Colors.transparent;
  static const Color white = Color(0xffFFFFFF);
  static const Color blue = Color(0xff017AB2);
  static const Color peacockBlue = Color(0xff006192);
  static const Color frenchBlue = Color(0xff007AB3);
  static const Color richElectricBlue = Color(0xff0094D9);
  static const Color solidBlue = Color(0xff00468A);
  static const Color black = Color(0xff001B3F);
  static const Color red = Color(0xffD11A38);
  static const Color gray = Color(0xffF2F2F2);
  static const Color gray2 = Color(0xff414141);
  static const Color gray3 = Color(0xffD9D9D9);
  static const Color gray4 = Color(0xffF5F5F5);
  static const Color gray5 = Color(0xffEDF0F7);
  static const Color gray6 = Color(0xffC9D1E2);
  static const Color gray7 = Color(0xff9E9E9E);
  static const Color disableGray = Color(0xff767676);
  static const Color carbonGrey = Color(0xff5B5B5B);
  static const Color lightGreen = Color(0xffEFF6EE);
  static const Color charcoalGrey = Color(0xff414141);
  static const Color lemonGrass = Color(0xff999999);
  static const Color bluishCyan = Color(0xffF1F9FA);
  static const Color silver = Color(0xffC2C2C2);
  static const Color wildSand = Color(0xffF4F4F4);
  static const Color codGray = Color(0xff1E1E1E);
  static const Color pinkish = Color(0xffFBF2F4);
  static const Color tuftsBlue = Color(0xff496EBD);

  // BackGround Colors
  static const Color whiteBGColor = white;
  static const Color bgColor = Color(0xffF7F9FC);
  static const Color authHomeBGColor = Color(0xFFEDF0F7);

  // Border and Shadow Colors
  static const Color shadowColor = Color(0xffDCDCDC);
  static const Color borderColor = Color(0xffEDF1F7);
  static const Color dividerLineColor = gray7;

  // Text Colors
  static const Color textBlackColor = black;
  static const Color textBlueColor = blue;
  static const Color textPeacockBlueColor = peacockBlue;
  static const Color textRedColor = red;
  static const Color textGrayColor = gray;
  static const Color textSolidBlueColor = solidBlue;
  static const Color textwhiteColor = white;
  static const Color textCarchoalGreyColor = charcoalGrey;
  static const Color textLemonGrassColor = lemonGrass;
}

Color hexStringToColor(String hexColor) {
  return UIColor.fromHex(hexColor) ?? ColorPalette.transparent;
}
