//
//  validation_result.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

class Result {
  bool value;
  String message;

  Result({required this.value, this.message = ""});

  factory Result.fromJson(Map<String, dynamic> json) {
    return Result(
      value: json['success'] ?? false,
      message: json['message'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'message': message,
    };
  }
}
