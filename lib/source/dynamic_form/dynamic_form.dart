//
//  dynamic_form.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'dart:convert';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter_ui_helper/source/dynamic_form/protocols/view_to_form_protocol.dart';

enum FormContentType {
  section,
  row,
  object,
}

class NotificationKeys {
  static const String screenMode = "screenMode";
  static const String languageMode = "languageMode";

  static const String formDependentObject = "formDependentObject";
  static const String formObjectType = "formObjectType";
  static const String formValue = "formValue";
  static const String senderKey = "senderKey";
}

class NotificationNames {
  static const screenModeChanged = "screenModeChanged";
  static const languageChanged = "languageChanged";
  static const updateFormObject = "updateFormObject";
  static const updateFormSection = "updateFormSection";
  static const updateFormRow = "updateFormRow";
  static const productChanged = "productChanged";
}

class DynamicForm implements ViewToFormProtocol {
  // Properties
  String version;
  @override
  List<FormSection> sections;

  // Class Constructor
  DynamicForm({required this.version, required this.sections});

  // =============== JSON Serialization =============== //
  // Deserialize JSON to Form
  factory DynamicForm.fromJson(Map<String, dynamic> json) {
    final sectionsJson = json['sections'] as List<dynamic>?;
    final sections = sectionsJson?.map((x) => FormSection.fromJson(x)).toList();
    return DynamicForm(version: json['version'] ?? '', sections: sections ?? []);
  }

  // Serialize Form To JSON
  Map<String, dynamic> toJson() {
    return {
      'sections': sections.map((section) => section.toJson()).toList(),
      'version': version,
    };
  }

  // =============== Convert Form To JSON String =============== //
  String convertFormToJSON() {
    try {
      return jsonEncode(this);
    } catch (error) {
      DebugPrint.error('Exception during convertFormToJSON: $error');
      return '';
    }
  }

  // =============== Create Form From JSON String =============== //
  factory DynamicForm.createFormFromJSON(String json) {
    try {
      final Map<String, dynamic> data = jsonDecode(json);
      final List<dynamic> sectionList = data['sections'] ?? [];
      final List<FormSection> sections = sectionList.map((x) => FormSection.fromJson(x)).toList();

      return DynamicForm(sections: sections, version: data['version'] ?? '');
    } catch (error) {
      DebugPrint.error('Exception during createFormFromJSON: $error');
      return DynamicForm(sections: [], version: '');
    }
  }

  // =============== send Notification =============== //
  static void sendNotificationTo(
    FormContentType formContentType,
    String senderKey, {
    String? value,
    FormType? senderFormType,
    required DependentObject senderDependentObj,
  }) {
    final Map<String, dynamic> objectInfo = {
      NotificationKeys.senderKey: senderKey,
      NotificationKeys.formDependentObject: senderDependentObj,
    };

    if (senderFormType != null) {
      objectInfo[NotificationKeys.formObjectType] = senderFormType;
    }
    if (value != null) {
      objectInfo[NotificationKeys.formValue] = value;
    }

    if (formContentType == FormContentType.section) {
      NotificationCenter.instance.post(NotificationType.updateFormSection, userInfo: objectInfo);
    } else if (formContentType == FormContentType.row) {
      NotificationCenter.instance.post(NotificationType.updateFormRow, userInfo: objectInfo);
    } else if (formContentType == FormContentType.object) {
      NotificationCenter.instance.post(NotificationType.updateFormObject, userInfo: objectInfo);
    }
  }

  static void sendNotificationToResetFormObject(String key, String sender) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.resetFormObject);
    sendNotificationTo(FormContentType.object, sender, senderDependentObj: dependent);
  }

  static void sendNotificationToSet(String key, String value, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.setValueFromView);
    sendNotificationTo(FormContentType.object, viewKey,
        value: value, senderDependentObj: dependent);
  }

  static void sendNotificationToSelectPopoverValue(String key, String value,
      {String viewKey = ''}) {
    final dependent =
        DependentObject(key: key, formOperation: FormOperation.selectValueInPopoverListFromCode);
    sendNotificationTo(FormContentType.object, viewKey,
        value: value, senderDependentObj: dependent);
  }

  static void sendNotificationToCopyValueInValidation(String key, String value, String valueKey) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.copyValueInValidation);
    sendNotificationTo(FormContentType.object, valueKey,
        value: value, senderDependentObj: dependent);
  }

  static void sendNotificationToShowSection(String key, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.showFormSection);
    sendNotificationTo(FormContentType.section, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToHideSection(String key, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.hideFormSection);
    sendNotificationTo(FormContentType.section, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToShowRow(String key, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.showFormRow);
    sendNotificationTo(FormContentType.row, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToHideRow(String key, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.hideFormRow);
    sendNotificationTo(FormContentType.row, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToShowObject(String key, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.showFormObject);
    sendNotificationTo(FormContentType.object, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToHideObject(String key, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.hideFormObject);
    sendNotificationTo(FormContentType.object, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToEnable(String key, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.enableFormObject);
    sendNotificationTo(FormContentType.object, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToDisable(String key, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.disableFormObject);
    sendNotificationTo(FormContentType.object, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToSetEditable(String key, {String viewKey = ''}) {
    final dependent = DependentObject(key: key, formOperation: FormOperation.setFormObjectEditable);
    sendNotificationTo(FormContentType.object, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToSetNonEditable(String key, {String viewKey = ''}) {
    final dependent =
        DependentObject(key: key, formOperation: FormOperation.setFormObjectNonEditable);
    sendNotificationTo(FormContentType.object, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToSetMandatory(String key, {String viewKey = ''}) {
    final dependent =
        DependentObject(key: key, formOperation: FormOperation.setFormObjectMandatory);
    sendNotificationTo(FormContentType.object, viewKey, senderDependentObj: dependent);
  }

  static void sendNotificationToSetNonMandatory(String key, {String viewKey = ''}) {
    final dependent =
        DependentObject(key: key, formOperation: FormOperation.setFormObjectNonMandatory);
    sendNotificationTo(FormContentType.object, viewKey, senderDependentObj: dependent);
  }

  // =============== View To Form Protocol Methods =============== //
  @override
  Result isValid() {
    return isValidExceptKeys([]);
  }

  @override
  Result isValidExceptKeys(List<String> exceptKeys) {
    for (var section in sections) {
      if (section.isHidden) continue;
      if (exceptKeys.contains(section.key)) continue;

      for (var formRow in section.formRows) {
        if (formRow.isHidden) continue;
        if (exceptKeys.contains(formRow.key)) continue;

        for (var formObject in formRow.formObjects) {
          if (exceptKeys.contains(formObject.key)) continue;
          final validation = formObject.isValid();
          if (!validation.value) {
            return validation;
          }
        }
      }
    }

    return Result(value: true);
  }

  @override
  Map<String, FormElementValue> getFormDetails() {
    final Map<String, FormElementValue> dictionary = {};

    for (var section in sections) {
      if (section.isHidden) continue;
      for (var formRow in section.formRows) {
        if (formRow.isHidden) continue;
        for (var formObject in formRow.formObjects) {
          dictionary[formObject.key] = FormElementValue(
            displayName: formObject.displayValue,
            code: formObject.value,
          );
        }
      }
    }

    return dictionary;
  }

  @override
  FormObject? getFormObjectForKey(String key) {
    for (var section in sections) {
      for (var formRow in section.formRows) {
        for (var formObject in formRow.formObjects) {
          if (formObject.key == key) return formObject;
        }
      }
    }

    return null;
  }

  @override
  void resetFormObjectsValue() {
    for (var section in sections) {
      for (var formRow in section.formRows) {
        for (var formObject in formRow.formObjects) {
          formObject.resetFormObjectValue();
        }
      }
    }
  }
}
