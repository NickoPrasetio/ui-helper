//
//  device.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 25/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

final class Device {
  static const double largeScreenLayoutWidth = 1200;
  static const double mediumScreenLayoutWidth = 600;
  static const double smallScreenLayoutWidth = 300;
  static bool isBrowser = kIsWeb;
  static bool isWindows = Platform.isWindows;
  static bool isLinux = Platform.isLinux;
  static bool isMacOS = Platform.isMacOS;
  static bool isAndroid = Platform.isAndroid;
  static bool isIOS = Platform.isIOS;

  // App Specific
  static bool isDesktopApp() {
    return !kIsWeb && (isWindows || isLinux || isMacOS);
  }

  static bool isHandheldDeviceApp() {
    return !kIsWeb && (isIOS || isAndroid);
  }

  // Theme context platform
  static bool platformDesktopBrowser(BuildContext context) {
    final platform = Theme.of(context).platform;
    if (platform == TargetPlatform.windows ||
        platform == TargetPlatform.macOS ||
        platform == TargetPlatform.linux) {
      return isBrowser;
    }
    return false;
  }

  static bool platformiOS(BuildContext context) {
    return !isBrowser && Theme.of(context).platform == TargetPlatform.iOS;
  }

  static bool platformAndroid(BuildContext context) {
    return !isBrowser && Theme.of(context).platform == TargetPlatform.android;
  }

  static bool platformIPad(BuildContext context) {
    return isMediumScreen(context) && platformiOS(context);
  }

  static bool platformAndroidTablet(BuildContext context) {
    return isMediumScreen(context) && platformAndroid(context);
  }

  // Layout Specific
  static double getScaleFactor(BuildContext context, double desktopFactor, double tabletFactor,
      double mobileFactor, double smallMobileFactor) {
    double scaleFactor = 1.0;
    if (isLargeScreen(context)) {
      scaleFactor = desktopFactor;
    } else if (isMediumScreen(context)) {
      scaleFactor = tabletFactor;
    } else if (isSmallScreen(context)) {
      scaleFactor = mobileFactor;
    } else {
      scaleFactor = smallMobileFactor;
    }
    return scaleFactor;
  }

  static bool isLargeScreen(BuildContext context) {
    return MediaQuery.of(context).size.width >= largeScreenLayoutWidth;
  }

  static bool isMediumScreenAndAbove(BuildContext context) {
    return MediaQuery.of(context).size.width >= mediumScreenLayoutWidth;
  }

  static bool isMediumScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= mediumScreenLayoutWidth && screenWidth < largeScreenLayoutWidth;
  }

  static bool isSmallScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth >= smallScreenLayoutWidth && screenWidth < mediumScreenLayoutWidth;
  }

  static bool isVerySmallScreen(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return screenWidth < smallScreenLayoutWidth;
  }
}
