//
//  form_section.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class FormSection {
  // Properties
  final String key;
  List<FormRow> formRows;
  String title;
  LabelProperties? titleLabel;
  bool isHidden;
  double height;
  bool isExpanded;
  bool hideHeader;
  String? backgroundColor;
  bool shouldAddBorder;
  double borderCornerRadius;
  String borderColorHex;
  double topSpace;
  double bottomSpace;

  // Class Constructor
  FormSection({
    required this.key,
    required this.formRows,
    this.isExpanded = true,
    this.hideHeader = true,
    this.title = '',
    this.titleLabel,
    this.isHidden = false,
    this.shouldAddBorder = false,
    this.borderCornerRadius = 12,
    this.borderColorHex = ColorPalette.gray3HexCode,
    this.topSpace = 0,
    this.bottomSpace = 0,
    this.backgroundColor = ColorPalette.grayHexCode,
    this.height = 40,
  }) {
    addNotificationObserver();
  }

  // =============== JSON Serialization =============== //
  // Deserialize JSON to FormSection
  factory FormSection.fromJson(Map<String, dynamic> json) {
    final rowsJson = json['formRows'] as List<dynamic>?;
    final formRows = rowsJson?.map((x) => FormRow.fromJson(x)).toList();

    return FormSection(
      key: json['key'] ?? '',
      isExpanded: json['isExpanded'] ?? false,
      hideHeader: json['hideHeader'] ?? false,
      title: json['title'],
      titleLabel: LabelProperties.fromJson(json['titleLabel']),
      isHidden: json['isHidden'] ?? false,
      formRows: formRows ?? [],
      shouldAddBorder: json['shouldAddBorder'] ?? false,
      borderCornerRadius: (json['borderCornerRadius'] as num?)?.toDouble() ?? 10,
      borderColorHex: json['borderColorHex'] ?? "#C4C4C4",
      topSpace: (json['topSpace'] as num?)?.toDouble() ?? 0,
      bottomSpace: (json['bottomSpace'] as num?)?.toDouble() ?? 0,
      backgroundColor: json['backgroundColor'] ?? '',
      height: json['height'] ?? '',
    );
  }

  // Serialize FormSection To JSON
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'isExpanded': isExpanded,
      'hideHeader': hideHeader,
      'title': title,
      'titleLabel': titleLabel?.toJson(),
      'isHidden': isHidden,
      'formRows': formRows.map((formRow) => formRow.toJson()).toList(),
      'shouldAddBorder': shouldAddBorder,
      'borderCornerRadius': borderCornerRadius,
      'borderColorHex': borderColorHex,
      'topSpace': topSpace,
      'bottomSpace': bottomSpace,
      'backgroundColor': backgroundColor,
      'height': height,
    };
  }

  // =============== Handle Notification =============== //
  void addNotificationObserver() {
    if (key.isNotEmpty) {
      NotificationCenter.instance.stream.listen((NotificationEvent notification) {
        if (notification.type == NotificationType.updateFormSection) {
          final senderDependentObj = notification.userInfo?[NotificationKeys.formDependentObject];

          if (senderDependentObj != null && senderDependentObj.key == key) {
            handleNotification(senderDependentObj);
          }
        }
      });
    }
  }

  void handleNotification(DependentObject senderDependentObj) {
    if (senderDependentObj.formOperation == FormOperation.showFormSection) {
      isHidden = false;
    } else if (senderDependentObj.formOperation == FormOperation.hideFormSection) {
      isHidden = true;

      for (FormRow formRow in formRows) {
        for (FormObject formObject in formRow.formObjects.where(
            (formObject) => formObject.formProperties.formType != FormType.labelTitleValuePair)) {
          formObject.resetFormObjectValue();
        }
      }
    }
  }
}
