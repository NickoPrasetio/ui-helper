//
//  enum_serialization.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 02/12/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

extension EnumSerialization<T extends Enum> on T {
  String toJson() => toString().split('.').last;

  static T fromJson<T extends Enum>(String? jsonValue, List<T> values, {required T defaultValue}) {
    if (jsonValue == null) {
      return defaultValue;
    }

    return values.firstWhere(
      (type) => type.toString().split('.').last == jsonValue,
    );
  }
}
