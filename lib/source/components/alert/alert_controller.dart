//
//  alert_controller.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter_ui_helper/source/constant/semantic_constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertController {
  static List<AdaptiveAlert> adaptiveAlertList = [];

  // Show Adaptive Alert
  static void showAdaptiveAlert(BuildContext context, AdaptiveAlert alert) {
    if (Device.platformiOS(context)) {
      showCupertinoDialog(
        context: context,
        builder: (context) => PopScope(canPop: false, child: alert),
        barrierDismissible: false,
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => PopScope(canPop: false, child: alert),
        barrierDismissible: false,
      );
    }
  }

  // Show Alert With Ok Button
  static void showAlertWith(String title, String message, String okBtnTitle, BuildContext context,
      {VoidCallback? onTap, bool showMultipleAlertOneAfterOther = false}) {
    final alert = AdaptiveAlert(
      semanticsIdentifier: SemanticsConstant.alertDialog,
      title: title,
      message: message,
      actions: [
        AdaptiveAlertButton(
          semanticsIdentifier: SemanticsConstant.alertOkBtn,
          child: AdaptiveText(text: okBtnTitle),
          onPressed: () {
            Navigator.pop(context);
            if (onTap != null) {
              onTap();
            }

            if (showMultipleAlertOneAfterOther) {
              _removeAndShowNextMessage(context);
            }
          },
        ),
      ],
    );

    if (showMultipleAlertOneAfterOther) {
      adaptiveAlertList.add(alert);
      _showAlertFromSavedList(context);
    } else {
      showAdaptiveAlert(context, alert);
    }
  }

  // Show Alert With Ok and cancel Button
  static void showOKCancelAlertWith(
    String title,
    String message,
    String okBtnTitle,
    String cancelBtnTitle,
    BuildContext context, {
    VoidCallback? onOkBtnTap,
    VoidCallback? onCancelBtnTap,
    bool showMultipleAlertOneAfterOther = false,
  }) {
    final okAlertButton = AdaptiveAlertButton(
      semanticsIdentifier: SemanticsConstant.alertOkBtn,
      child: AdaptiveText(text: okBtnTitle),
      onPressed: () {
        Navigator.pop(context);
        if (onOkBtnTap != null) {
          onOkBtnTap();
        }

        if (showMultipleAlertOneAfterOther) {
          _removeAndShowNextMessage(context);
        }
      },
    );

    final cancelAlertButton = AdaptiveAlertButton(
      semanticsIdentifier: SemanticsConstant.alertCancelBtn,
      child: AdaptiveText(text: cancelBtnTitle),
      onPressed: () {
        Navigator.pop(context);
        if (onCancelBtnTap != null) {
          onCancelBtnTap();
        }

        if (showMultipleAlertOneAfterOther) {
          _removeAndShowNextMessage(context);
        }
      },
    );

    final alert = AdaptiveAlert(
      semanticsIdentifier: SemanticsConstant.alertDialog,
      title: title,
      message: message,
      actions: (!Device.isBrowser && Device.isIOS)
          ? [cancelAlertButton, okAlertButton]
          : [okAlertButton, cancelAlertButton],
    );

    if (showMultipleAlertOneAfterOther) {
      adaptiveAlertList.add(alert);
      _showAlertFromSavedList(context);
    } else {
      showAdaptiveAlert(context, alert);
    }
  }

  // Show Alerts from adaptiveAlertList - Multiple Alert One After Other
  static void _showAlertFromSavedList(BuildContext context) {
    if (adaptiveAlertList.isNotEmpty) {
      final alert = adaptiveAlertList[0];
      showAdaptiveAlert(context, alert);
    }
  }

  static void _removeAndShowNextMessage(BuildContext context) {
    if (adaptiveAlertList.isNotEmpty) {
      adaptiveAlertList.removeAt(0);
    }
    _showAlertFromSavedList(context);
  }
}
