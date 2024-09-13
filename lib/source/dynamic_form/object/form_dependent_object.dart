//
//  form_dependent_object.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'dart:convert';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class DependentObject {
  // Properties
  String key;
  FormOperation formOperation;

  // Class Constructor
  DependentObject({required this.key, required this.formOperation});

  // =============== JSON Serialization =============== //
  // Deserialize JSON to PopOverMenuItem
  factory DependentObject.fromJson(Map<String, dynamic> json) {
    return DependentObject(
      key: json['key'] as String? ?? '',
      formOperation: EnumSerialization.fromJson(
        json['formType'],
        FormOperation.values,
        defaultValue: FormOperation.resetFormObject,
      ),
    );
  }

  // Serialize FormRow To JSON
  Map<String, dynamic> toJson() {
    return {'key': key, 'operation': jsonEncode(formOperation.toJson())};
  }
}
