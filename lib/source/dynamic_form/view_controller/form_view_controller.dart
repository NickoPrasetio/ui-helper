//
//  form_view_controller.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 21/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/source/dynamic_form/protocols/view_to_form_protocol.dart';

enum FormViewControllerOperation { reload, empty }

class FormViewController extends StatefulWidget {
  // Properties
  final ViewToFormProtocol form;
  final bool shouldValidate;
  final FormViewControllerOperation Function(NotificationEvent notification) observer;
  final void Function(String key)? buttonAction;

  // Class Constructor
  const FormViewController({
    super.key,
    required this.form,
    required this.observer,
    this.shouldValidate = false,
    this.buttonAction,
  });

  // Widget State
  @override
  State<FormViewController> createState() => _FormViewControllerState();
}

class _FormViewControllerState extends State<FormViewController> {
  bool _shouldValidate = false;

  Result validateAllFields() {
    _shouldValidate = true;
    _reload();

    return widget.form.isValid();
  }

  // Widget Methods
  @override
  void initState() {
    super.initState();
    _addNotificationObserver();
    _shouldValidate = widget.shouldValidate;
  }

  @override
  Widget build(BuildContext context) {
    _shouldValidate = widget.shouldValidate;
    return ListView.builder(
      itemCount: widget.form.sections.length,
      itemBuilder: (BuildContext context, int index) {
        var section = widget.form.sections[index];
        return Column(
          children: [
            SizedBox(height: section.topSpace),
            Container(
              decoration: HelperConstant.getBorderBoxDecoration(
                shadow: [HelperConstant.getBoxShadow2()],
                borderColor: hexStringToColor(section.borderColorHex),
              ),
              child: Column(
                children: [
                  if (!section.hideHeader) ...{
                    AdaptiveTapGesture(
                      onTap: () {
                        setState(() {
                          section.isExpanded = !section.isExpanded;
                        });
                      },
                      child: Container(
                        height: section.height,
                        padding: const EdgeInsets.only(left: 8, right: 8),
                        decoration: HelperConstant.getBorderBoxDecoration(
                          bgColor: hexStringToColor(section.backgroundColor ?? ''),
                          borderColor: Colors.transparent,
                          cornerRadius: section.borderCornerRadius,
                          borderRadiusTypes: section.isExpanded
                              ? [BorderRadiusType.topLeft, BorderRadiusType.topRight]
                              : [BorderRadiusType.all],
                        ),
                        child: Row(
                          children: [
                            DynamicFormText(
                                shouldValidate: _shouldValidate,
                                formkey: 'Section_${index}_Title',
                                text: section.title,
                                isValid: true,
                                labelProperties: section.titleLabel ?? LabelProperties()),
                            const Spacer(),
                            Icon(
                              section.isExpanded
                                  ? Icons.arrow_drop_up_sharp
                                  : Icons.arrow_drop_down_sharp,
                            ),
                          ],
                        ),
                      ),
                    ),
                  },
                  if (section.isExpanded) ...{
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: section.formRows.where((row) => !row.isHidden).map(
                        (row) {
                          final rowObject = Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: row.formObjects.map((obj) {
                              if (obj.isHidden) {
                                return const EmptyWidget();
                              }
                              return Expanded(child: _buildWidgetForFormObject(obj));
                            }).toList(),
                          );

                          if (rowObject.children.every((obj) => obj is EmptyWidget)) {
                            return const EmptyWidget();
                          }

                          return Container(
                            margin: EdgeInsets.only(
                              top: row.topSpacing,
                              bottom: row.bottomSpacing,
                              left: row.leftSpacing,
                              right: row.rightSpacing,
                            ),
                            child: rowObject,
                          );
                        },
                      ).toList(),
                    ),
                  },
                ],
              ),
            ),
            SizedBox(height: section.bottomSpace),
          ],
        );
      },
    );
  }

  // Object Level Private Methods
  void _reload() {
    setState(() {});
  }

  void _addNotificationObserver() {
    NotificationCenter.instance.stream.listen((NotificationEvent notification) {
      final type = widget.observer(notification);
      if (type == FormViewControllerOperation.reload) {
        _reload();
      }
    });
  }

  Widget _buildWidgetForFormObject(FormObject formObject) {
    switch (formObject.formProperties.formType) {
      case FormType.emptySpace:
        return _getEmptySpace(formObject);

      case FormType.label:
        return _getLabel(formObject);

      case FormType.labelWithRadioButton:
        return _getLabelWithRadioButton(formObject);

      case FormType.labelWithCheckBoxButton:
        return _getLabelWithCheckBoxButton(formObject);

      case FormType.button:
        return _getButton(formObject);

      case FormType.labelTitleValuePair:
        return _getAdaptiveTitleValueText(formObject);

      case FormType.labelWithTextField:
        return _getLabelWithTextField(formObject);

      default:
        return const EmptyWidget();
    }
  }

  Widget _getEmptySpace(FormObject formObject) {
    final emptySpaceProperties = formObject.formProperties.emptySpaceProperties;
    return AdaptiveSizedBox(height: emptySpaceProperties?.height);
  }

  DynamicFormText _getLabel(FormObject formObject) {
    return DynamicFormText(
      shouldValidate: _shouldValidate,
      formkey: formObject.key,
      text: formObject.title,
      labelProperties: formObject.formProperties.labelProperties ?? LabelProperties(),
    );
  }

  DynamicFormRadioButton _getLabelWithRadioButton(FormObject formObject) {
    return DynamicFormRadioButton(
      shouldValidate: _shouldValidate,
      formObject: formObject,
      onChanged: (value) {
        setState(() {
          formObject.value = value;
        });
      },
    );
  }

  DynamicFormCheckBoxButton _getLabelWithCheckBoxButton(FormObject formObject) {
    return DynamicFormCheckBoxButton(
      shouldValidate: _shouldValidate,
      formObject: formObject,
      onChanged: (valueList) {
        setState(() {
          formObject.value = valueList.join(', ');
        });
      },
    );
  }

  Widget _getButton(FormObject formObject) {
    final buttonProperties = formObject.formProperties.buttonProperties ?? ButtonProperties();
    return AdaptiveButton(
      titleText: formObject.title,
      buttonType: buttonProperties.buttonType,
      padding: EdgeInsets.all(buttonProperties.padding),
      isDisabled: buttonProperties.isDisabled,
      color: hexStringToColor(buttonProperties.colorHex),
      textAlign: buttonProperties.textAlign,
      fontSize: buttonProperties.fontSize,
      fontSystem: buttonProperties.fontSystem,
      addGradient: buttonProperties.addGradient,
      desktopFactor: buttonProperties.desktopFactor,
      tabletFactor: buttonProperties.tabletFactor,
      mobileFactor: buttonProperties.mobileFactor,
      smallMobileFactor: buttonProperties.smallMobileFactor,
      onTap: () {
        if (widget.buttonAction != null) {
          widget.buttonAction!(formObject.key);
        }
      },
    );
  }

  Widget _getAdaptiveTitleValueText(FormObject formObject) {
    final titleValueProperties = formObject.formProperties.titleValueProperties;
    if (titleValueProperties != null) {
      return AdaptiveTitleValueText(
        icon: titleValueProperties.icon,
        titleLabel: DynamicFormText(
          shouldValidate: _shouldValidate,
          formkey: '${formObject.key}_title',
          text: formObject.title,
          labelProperties: titleValueProperties.titleLabel,
        ),
        valueLabel: DynamicFormText(
          shouldValidate: _shouldValidate,
          formkey: '${formObject.key}_value',
          text: formObject.value,
          labelProperties: titleValueProperties.valueLabel,
        ),
        crossAxisAlignment: titleValueProperties.crossAxisAlignment,
        layoutDirection: titleValueProperties.layoutDirection,
      );
    }
    return const EmptyWidget();
  }

  DynamicFormTextField _getLabelWithTextField(FormObject formObject) =>
      DynamicFormTextField(formObject: formObject, shouldValidate: _shouldValidate);
}
