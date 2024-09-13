/*
  search_text_field.dart
  
  Created by GABRIELSORE on 20/05/24.
  Copyright © 2024 Allianz. All rights reserved.
*/

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? textFieldSemanticsIdentifier;
  final String? clearSearchButtonSemanticsIdentifier;
  final String? searchButtonSemanticsIdentifier;
  final String? hintText;
  final String? searchButtonText;
  final Widget? searchIcon;
  final Widget? clearBtn;
  final double? width;
  final Function()? onClearSearchButtonTap;
  final Function(String)? onSearchButtonTap;

  // Class Constructor
  const SearchTextField({
    super.key,
    required this.controller,
    this.textFieldSemanticsIdentifier,
    this.clearSearchButtonSemanticsIdentifier,
    this.searchButtonSemanticsIdentifier,
    this.hintText,
    this.searchButtonText,
    this.searchIcon,
    this.clearBtn,
    this.width = 120,
    this.onClearSearchButtonTap,
    this.onSearchButtonTap,
  });

  @override
  Widget build(BuildContext context) {
    return _searchTextField();
  }

  Widget _searchTextField() {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        AdaptiveTextFormField(
          textFieldType: AdaptiveTextFormFieldType.boxShowingHint,
          semanticsIdentifier: textFieldSemanticsIdentifier,
          controller: controller,
          boxBorderWidth: 1.0,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 21),
          boxFillColor: ColorPalette.whiteBGColor,
          hintText: hintText ?? '',
          prefix: Padding(padding: const EdgeInsets.symmetric(horizontal: 16), child: searchIcon),
        ),
        Positioned(right: 0, child: _suffixSearchBar()),
      ],
    );
  }

  Widget _suffixSearchBar() {
    return Row(
        textDirection: TextDirection.rtl,
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [_searchButton(), _clearSearchButton()]);
  }

  Widget _clearSearchButton() {
    return Semantics(
        label: clearSearchButtonSemanticsIdentifier,
        excludeSemantics: true,
        child: IconButton(
            icon: clearBtn ?? Container(),
            padding: EdgeInsets.zero,
            onPressed: () {
              controller.clear();
              if (onClearSearchButtonTap != null) {
                onClearSearchButtonTap!();
              }
            }));
  }

  Widget _searchButton() {
    return Container(
        width: width,
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: AdaptiveButton(
          titleText: searchButtonText ?? '',
          buttonType: AdaptiveButtonType.blueButton,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          fontSize: UIFont.h7,
          semanticsIdentifier: searchButtonSemanticsIdentifier,
          onTap: () {
            if (onSearchButtonTap != null) {
              onSearchButtonTap!(controller.text);
            }
          },
        ));
  }
}
