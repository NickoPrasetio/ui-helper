//
//  view_to_form_protocol.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';

abstract class ViewToFormProtocol {
  List<FormSection> get sections;

  Result isValid();
  Result isValidExceptKeys(List<String> exceptKeys);
  void resetFormObjectsValue();
  Map<String, FormElementValue> getFormDetails();
  FormObject? getFormObjectForKey(String key);
}
