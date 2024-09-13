//
//  terms_condition_widget.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 23/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

enum TermsAndConditionsContentType { string, rtfFile, widget }

class TermsAndConditionsWidget extends StatefulWidget {
  // Properties
  final AdaptiveText title;
  final AdaptiveText checkBoxMessage;
  final TermsAndConditionsContentType contentType;
  final ValueChanged<bool?>? onChanged;
  final Color checkboxColor;
  final Color contentColor;
  final Color contentBorderColor;
  final Map<String, String> replacements;

  final Widget? child;
  final String rtfAssetPath;
  final String stringContent;
  final double fontSize;

  // Class Constructor
  const TermsAndConditionsWidget({
    super.key,
    required this.title,
    required this.checkBoxMessage,
    this.onChanged,
    this.checkboxColor = ColorPalette.blue,
    this.contentColor = ColorPalette.white,
    this.contentBorderColor = ColorPalette.gray3,
    this.replacements = const {},
    this.child,
    this.rtfAssetPath = 'assets/rtf/test.rtf',
    this.contentType = TermsAndConditionsContentType.rtfFile,
    this.stringContent = '',
    this.fontSize = UIFont.h6,
  });

  // Widget State
  @override
  State<TermsAndConditionsWidget> createState() => _TermsAndConditionsWidgetState();
}

class _TermsAndConditionsWidgetState extends State<TermsAndConditionsWidget> {
  late ScrollController _scrollController;
  bool _isChecked = false;

  // Widget Methods
  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients && !canScroll(_scrollController)) {
        _scrollListener();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // Object Level Private Methods
  void _scrollListener() {
    if (_scrollController.offset >= _scrollController.position.maxScrollExtent) {
      setState(() {
        _isChecked = true;
      });

      if (widget.onChanged != null && _isChecked) {
        widget.onChanged!(_isChecked);
      }
    }
  }

  bool canScroll(ScrollController controller) {
    if (controller.hasClients) {
      final maxScrollExtent = controller.position.maxScrollExtent;
      final minScrollExtent = controller.position.minScrollExtent;
      final currentOffset = controller.offset;
      return currentOffset < maxScrollExtent || currentOffset > minScrollExtent;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    Widget child = RTFViewerWidget(
      scrollController: _scrollController,
      rtfAssetPath: widget.rtfAssetPath,
      replacements: widget.replacements,
    );

    if (widget.contentType == TermsAndConditionsContentType.widget) {
      child = SingleChildScrollView(controller: _scrollController, child: widget.child);
    } else if (widget.contentType == TermsAndConditionsContentType.string) {
      child = StringTextViewerWidget(
        scrollController: _scrollController,
        content: widget.stringContent,
        replacements: widget.replacements,
        fontSize: widget.fontSize,
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Center(child: widget.title),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
            child: Container(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              decoration: HelperConstant.getBorderBoxDecoration(
                shadow: [HelperConstant.getBoxShadow2()],
                borderColor: widget.contentBorderColor,
                bgColor: widget.contentColor,
                width: 2,
              ),
              child: child,
            ),
          ),
        ),
        CheckboxListTile(
          contentPadding: EdgeInsets.zero,
          enabled: _isChecked,
          value: _isChecked,
          onChanged: (value) {},
          title: widget.checkBoxMessage,
          controlAffinity: ListTileControlAffinity.leading,
          activeColor: widget.checkboxColor,
        ),
      ],
    );
  }
}
