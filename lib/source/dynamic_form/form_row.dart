//
//  form_row.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class FormRow {
  // Properties
  final String key;
  List<FormObject> formObjects;
  double spaceBtwObjects;
  bool isHidden;
  double numberOfDivisionInRow;
  double topSpacing;
  double bottomSpacing;
  double leftSpacing;
  double rightSpacing;
  bool shouldAddBottomLine;
  String bottomLineColor;

  // Class Constructor
  FormRow({
    required this.formObjects,
    this.key = '',
    this.spaceBtwObjects = 10,
    this.isHidden = false,
    this.numberOfDivisionInRow = 1,
    this.shouldAddBottomLine = false,
    this.bottomLineColor = "#C4C4C4",
    this.topSpacing = 0,
    this.bottomSpacing = 0,
    this.leftSpacing = 0,
    this.rightSpacing = 0,
  }) {
    addNotificationObserver();
  }

  // =============== JSON Serialization =============== //
  // Deserialize JSON to FormRow
  factory FormRow.fromJson(Map<String, dynamic> json) {
    final formObjectsJson = json['formObjects'] as List<dynamic>?;
    final formObjects = formObjectsJson?.map((x) => FormObject.fromJson(x)).toList();

    return FormRow(
      key: json['key'] ?? '',
      formObjects: formObjects ?? [],
      spaceBtwObjects: json['spaceBtwObjects'] ?? 0.0,
      isHidden: json['isHidden'] ?? false,
      numberOfDivisionInRow: json['numberOfDivisionInRow'] ?? 1.0,
      topSpacing: json['topSpacing'] ?? 0.0,
      bottomSpacing: json['bottomSpacing'] ?? 0.0,
      leftSpacing: json['leftSpacing'] ?? 0.0,
      rightSpacing: json['rightSpacing'] ?? 0.0,
      shouldAddBottomLine: json['shouldAddBottomLine'] ?? false,
      bottomLineColor: json['bottomLineColor'] ?? '',
    );
  }

  // Serialize FormRow To JSON
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'formObjects': formObjects.map((formObject) => formObject.toJson()).toList(),
      'spaceBtwObjects': spaceBtwObjects,
      'isHidden': isHidden,
      'numberOfDivisionInRow': numberOfDivisionInRow,
      'topSpacing': topSpacing,
      'bottomSpacing': bottomSpacing,
      'leftSpacing': leftSpacing,
      'rightSpacing': rightSpacing,
      'shouldAddBottomLine': shouldAddBottomLine,
      'bottomLineColor': bottomLineColor,
    };
  }

  // =============== Handle Notification =============== //
  void addNotificationObserver() {
    if (key.isNotEmpty) {
      NotificationCenter.instance.stream.listen((NotificationEvent notification) {
        if (notification.type == NotificationType.updateFormRow) {
          final senderDependentObj = notification.userInfo?[NotificationKeys.formDependentObject];

          if (senderDependentObj != null && senderDependentObj.key == key) {
            handleNotification(senderDependentObj);
          }
        }
      });
    }
  }

  void handleNotification(DependentObject senderDependentObj) {
    if (senderDependentObj.formOperation == FormOperation.showFormRow) {
      isHidden = false;
    } else if (senderDependentObj.formOperation == FormOperation.hideFormRow) {
      isHidden = true;

      for (FormObject formObject in formObjects) {
        if (formObject.formProperties.formType != FormType.labelTitleValuePair) {
          formObject.resetFormObjectValue();
        }
      }
    }
  }
}
