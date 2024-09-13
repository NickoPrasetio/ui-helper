//
//  form_object.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'dart:convert';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class FormObject {
  // Properties
  static const String valueKey = 'FormObjectValueForREGEX';

  String _value = '';
  String get value => _value;

  set value(String newValue) {
    notifyDependentsOnValueChanged(newValue);
    _value = newValue;
  }

  final String key;
  String displayValue;
  String title;
  String? placeholder;

  List<String>? valueList;
  List<PopOverMenuItem>? popOverValueList;

  FormProperties formProperties;

  List<DependentObject>? dependents;
  List<Regex>? validations;

  Map<String, String>? validationObjectDic;

  bool isEditable;
  bool isMandatory;
  bool isHidden;
  bool showTitleLbl;

  // Class Constructor
  FormObject({
    required this.key,
    required this.formProperties,
    this.title = '',
    String value = '',
    this.displayValue = '',
    this.isEditable = true,
    this.isMandatory = true,
    this.isHidden = false,
    this.showTitleLbl = false,
    this.placeholder,
    this.valueList,
    this.popOverValueList,
    this.dependents,
    this.validations,
    this.validationObjectDic,
  }) : _value = value {
    addNotificationObserver();
    notifyDependentsOnValueChanged(_value);
  }

  // =============== JSON Serialization =============== //
  // Deserialize JSON to FormObject
  factory FormObject.fromJson(Map<String, dynamic> json) {
    final popOverValueList = (json['popOverValueList'] as List<dynamic>?)
        ?.map((item) => PopOverMenuItem.fromJson(item))
        .toList();

    final dependents = (json['dependents'] as List<dynamic>?)
        ?.map((item) => DependentObject.fromJson(item))
        .toList();

    final validations =
        (json['validations'] as List<dynamic>?)?.map((item) => Regex.fromJson(item)).toList();

    return FormObject(
      key: json['key'] ?? '',
      value: json['value'] ?? '',
      displayValue: json['displayValue'] ?? '',
      title: json['title'] ?? '',
      placeholder: json['placeholder'],
      valueList: (json['valueList'] as List<dynamic>?)?.cast<String>(),
      popOverValueList: popOverValueList ?? [],
      formProperties: FormProperties.fromJson(jsonDecode(json['formProperties'])),
      dependents: dependents ?? [],
      validations: validations ?? [],
      validationObjectDic: json['validationObjectDic'] ?? {},
      isEditable: json['isEditable'] ?? true,
      isMandatory: json['isMandatory'] ?? true,
      isHidden: json['isHidden'] ?? false,
      showTitleLbl: json['showTitleLbl'] ?? false,
    );
  }

  // Serialize FormObject to JSON
  Map<String, dynamic> toJson() {
    return {
      'key': key,
      'value': value,
      'displayValue': displayValue,
      'title': title,
      'placeholder': placeholder,
      'valueList': valueList,
      'popOverValueList': popOverValueList?.map((item) => item.toJson()).toList(),
      'formProperties': jsonEncode(formProperties.toJson()),
      'dependents': dependents?.map((item) => jsonEncode(item.toJson())).toList(),
      'validations': validations?.map((item) => jsonEncode(item.toJson())).toList(),
      'validationObjectDic': validationObjectDic,
      'isEditable': isEditable,
      'isMandatory': isMandatory,
      'isHidden': isHidden,
      'showTitleLbl': showTitleLbl,
    };
  }

  // =============== Handle Notification =============== //
  void notifyDependentsOnValueChanged(String newValue) {
    if (dependents != null) {
      for (final dependent in dependents!) {
        final objectInfo = {
          NotificationKeys.senderKey: key,
          NotificationKeys.formDependentObject: dependent,
          NotificationKeys.formValue: newValue,
          NotificationKeys.formObjectType: formProperties.formType,
        };

        if (dependent.formOperation == FormOperation.changeSectionTitle ||
            dependent.formOperation == FormOperation.hideFormSection ||
            dependent.formOperation == FormOperation.showFormSection) {
          // Update Form Section
          NotificationCenter.instance
              .post(NotificationType.updateFormSection, userInfo: objectInfo);
        } else if (dependent.formOperation == FormOperation.hideFormRow ||
            dependent.formOperation == FormOperation.showFormRow) {
          // Update Form Row
          NotificationCenter.instance.post(NotificationType.updateFormRow, userInfo: objectInfo);
        } else {
          // Update Form Object
          NotificationCenter.instance.post(NotificationType.updateFormObject, userInfo: objectInfo);
        }
      }
    }
  }

  void addNotificationObserver() {
    if (key.isNotEmpty) {
      NotificationCenter.instance.stream.listen((NotificationEvent notification) {
        if (notification.type == NotificationType.updateFormObject) {
          final senderDependentObj = notification.userInfo?[NotificationKeys.formDependentObject];

          if (senderDependentObj != null && senderDependentObj.key == key) {
            // Operations without Sender Value in Notification
            if (senderDependentObj.formOperation == FormOperation.resetFormObject) {
              resetFormObjectValue();
            } else if (senderDependentObj.formOperation == FormOperation.showFormObject) {
              isHidden = false;
            } else if (senderDependentObj.formOperation == FormOperation.hideFormObject) {
              isHidden = true;
              resetFormObjectValue();
            } else if (senderDependentObj.formOperation == FormOperation.enableFormObject ||
                senderDependentObj.formOperation == FormOperation.setFormObjectEditable) {
              isEditable = true;
            } else if (senderDependentObj.formOperation == FormOperation.disableFormObject) {
              isEditable = false;
              isMandatory = false;
              resetFormObjectValue();
            } else if (senderDependentObj.formOperation == FormOperation.setFormObjectNonEditable) {
              isEditable = false;
              resetFormObjectValue();
            } else if (senderDependentObj.formOperation == FormOperation.setFormObjectMandatory) {
              isMandatory = true;
            } else if (senderDependentObj.formOperation ==
                FormOperation.setFormObjectNonMandatory) {
              isMandatory = false;
            }

            // Operations with Sender Value in Notification
            final senderKey = notification.userInfo?[NotificationKeys.senderKey] as String?;
            final senderValue = notification.userInfo?[NotificationKeys.formValue] as String?;
            final senderFormType =
                notification.userInfo?[NotificationKeys.formObjectType] as FormType?;

            if (senderKey != null && senderValue != null && senderFormType != null) {
              handleNotification(senderKey, senderValue, senderFormType, senderDependentObj);
            }
          }
        }
      });
    }
  }

  void handleNotification(String senderKey, String senderValue, FormType senderFormType,
      DependentObject senderDependentObj) {
    if (senderDependentObj.formOperation == FormOperation.selectValueInPopoverListFromCode) {
      final menuList = popOverValueList;
      final code = senderValue;
      final menu = menuList?.firstWhere((menu) => menu.code == code);

      if (menu != null) {
        value = menu.code;
        displayValue = menu.displayName;
      } else {
        resetFormObjectValue();
      }
    } else if (senderDependentObj.formOperation == FormOperation.copyValueInValidation) {
      if (validationObjectDic == null) {
        validationObjectDic = {senderKey: senderValue};
      } else {
        validationObjectDic?[senderKey] = senderValue;
      }
    } else if (senderDependentObj.formOperation == FormOperation.setValueFromView) {
      final dependent = List<DependentObject>.from(dependents ?? []);
      dependents = null;
      value = senderValue;
      dependents = dependent;
    }
  }

  // =============== Object Validation =============== //
  Result isValid() {
    final ignoreValidationList = [
      FormType.emptySpace,
      FormType.label,
      FormType.labelTitleValuePair,
      FormType.button
    ];

    final checkRegexList = [
      FormType.labelWithTextField,
    ];

    if (!ignoreValidationList.contains(formProperties.formType)) {
      if (value.isEmpty) {
        if (!isMandatory || isHidden) {
          return Result(value: true);
        }
        return Result(value: false, message: '$title cannot be blank');
      }

      if (checkRegexList.contains(formProperties.formType)) {
        if (validations != null) {
          for (Regex regex in validations!) {
            final result = regex.validate(value);
            if (!result) {
              return Result(value: result, message: regex.errorMessage);
            }
          }
        }
      }
    }

    return Result(value: true);
  }

  void resetFormObjectValue() {
    final dependent = dependents;
    dependents = null;
    value = '';
    dependents = dependent;
    displayValue = '';
  }

  Map<String, double> getValueDict() {
    final valueDict = <String, double>{};

    if (validationObjectDic != null) {
      for (final items in validationObjectDic!.entries) {
        final value = double.tryParse(items.value);
        if (value != null) {
          valueDict[items.key] = value;
        }
      }
    }

    return valueDict;
  }

  void updateValueChanged({String viewKey = ''}) {
    dependents ??= [];
    dependents!.addAll([
      DependentObject(key: viewKey, formOperation: FormOperation.updateViewOnValueChanged),
    ]);
  }
}
