//
//  form_popover_menu_item.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';

class PopOverMenuItem {
  // Properties
  String code;
  String displayName;
  String codeDesc;
  bool isSelected;
  bool isRecommended;
  String recommendedText;
  String relatedObjectCode;
  IconData? iconData;

  // Class Constructor
  PopOverMenuItem({
    required this.code,
    required this.displayName,
    this.codeDesc = '',
    this.isSelected = false,
    this.isRecommended = false,
    this.recommendedText = '',
    this.relatedObjectCode = '',
    this.iconData,
  });

  // =============== JSON Serialization =============== //
  // Deserialize JSON to PopOverMenuItem
  factory PopOverMenuItem.fromJson(Map<String, dynamic> json) {
    return PopOverMenuItem(
      code: json['code'] as String,
      displayName: json['displayName'] as String,
      codeDesc: json['codeDesc'] as String? ?? '',
      isSelected: json['isSelected'] as bool? ?? false,
      isRecommended: json['isRecommended'] as bool? ?? false,
      recommendedText: json['recommendedText'] as String? ?? '',
      relatedObjectCode: json['relatedObjectCode'] as String? ?? '',
      iconData: null,
    );
  }

  // Serialize FormRow To JSON
  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'displayName': displayName,
      'codeDesc': codeDesc,
      'isSelected': isSelected,
      'isRecommended': isRecommended,
      'recommendedText': recommendedText,
      'relatedObjectCode': relatedObjectCode,
      'iconData': iconData != null
          ? {
              'codePoint': iconData!.codePoint,
              'fontFamily': iconData!.fontFamily,
            }
          : null,
    };
  }
}
