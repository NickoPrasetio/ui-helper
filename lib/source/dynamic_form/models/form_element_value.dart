//
//  form_element_value.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

class FormElementValue {
  String displayName;
  String code;

  FormElementValue({required this.displayName, required this.code});

  factory FormElementValue.fromJson(Map<String, dynamic> json) {
    return FormElementValue(
      displayName: json['displayName'] as String? ?? '',
      code: json['code'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'displayName': displayName, 'code': code};
  }
}
