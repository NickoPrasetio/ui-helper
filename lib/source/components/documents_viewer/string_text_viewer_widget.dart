//
//  string_document_widget.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 23/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class StringTextViewerWidget extends StatelessWidget {
  // Properties
  final String content;
  final Map<String, String> replacements;
  final ScrollController scrollController;
  final double fontSize;
  final double lineSpacing;

  // Class Constructor
  const StringTextViewerWidget({
    super.key,
    required this.content,
    required this.scrollController,
    this.replacements = const {},
    this.fontSize = UIFont.h6,
    this.lineSpacing = 1.5,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    String str = content;
    if (content.isNotEmpty) {
      replacements.forEach((key, value) {
        str = str.replaceAll(key, value);
      });
    }

    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: _parseParagraphs(str),
      ),
    );
  }

  // Object Level Private Methods
  List<Widget> _parseParagraphs(String rtfContent) {
    List<String> paragraphs = rtfContent.split('\n');

    return paragraphs.map((paragraph) {
      if (RegExp(r'^\d+\.').hasMatch(paragraph)) {
        return _buildNumberedListItem(paragraph);
      } else if (paragraph.startsWith('\t\t')) {
        return _buildNestedListItem(paragraph, 32);
      } else if (paragraph.startsWith('\t')) {
        return _buildNestedListItem(paragraph, 16);
      } else {
        return _buildRegularText(paragraph);
      }
    }).toList();
  }

  Widget _buildNumberedListItem(String paragraph) {
    String number = '${paragraph.split('.')[0]}.';
    String text = paragraph.replaceFirst(number, '').trim();
    return _buildText(text: text, serialNumber: number);
  }

  Widget _buildRegularText(String text) {
    return _buildText(text: text, textAlign: TextAlign.left);
  }

  Widget _buildNestedListItem(String paragraph, double leftSpace) {
    String number = '${paragraph.split('.')[0]}.';
    String text = paragraph.replaceFirst(number, '').trim();

    return _buildText(
        padding: EdgeInsets.only(top: 8, left: leftSpace), text: text, serialNumber: number);
  }

  Widget _buildText({
    required String text,
    String serialNumber = '',
    TextAlign textAlign = TextAlign.justify,
    EdgeInsets padding = const EdgeInsets.only(top: 8),
  }) {
    if (text.contains('ACL_TAG_')) {
      return _buildRichTexts(text, padding: padding, serialNumber: serialNumber);
    }
    return Padding(
      padding: padding,
      child: AdaptiveText(
        text: text,
        fontSize: fontSize,
        serialNumberText: serialNumber,
        textAlign: textAlign,
      ),
    );
  }

  Widget _buildRichTexts(
    String text, {
    String serialNumber = '',
    TextAlign textAlign = TextAlign.justify,
    EdgeInsets padding = const EdgeInsets.only(top: 8),
  }) {
    return Padding(
      padding: padding,
      child: AdaptiveText.richText(
        richTextSpans: _parse(text),
        fontSize: fontSize,
        textAlign: textAlign,
        serialNumberText: serialNumber,
      ),
    );
  }

  List<TextSpan> _parse(String text) {
    String boldOpeningTag = '<ACL_TAG_BOLD>';
    String boldClosingTag = '</ACL_TAG_BOLD>';
    String currentBoldTag = '';

    String italicOpeningTag = '<ACL_TAG_ITALIC>';
    String italicClosingTag = '</ACL_TAG_ITALIC>';
    String currentItalicTag = '';

    List<TextSpan> textSpans = [];
    List<String> words = text.split(' ');

    for (int index = 0; index < words.length; index++) {
      String word = words[index];
      String nextWord = '';
      if (index + 1 < words.length) {
        nextWord = words[index + 1];
      }
      if (word == boldOpeningTag) {
        currentBoldTag = boldOpeningTag;
      } else if (word == boldClosingTag) {
        currentBoldTag = '';
      } else if (currentBoldTag.isNotEmpty) {
        textSpans.add(
          TextSpan(
            text: nextWord == boldClosingTag ? word : '$word ',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: fontSize, height: lineSpacing),
          ),
        );
      } else if (word == italicOpeningTag) {
        currentItalicTag = italicOpeningTag;
      } else if (word == italicClosingTag) {
        currentItalicTag = '';
      } else if (currentItalicTag.isNotEmpty) {
        textSpans.add(
          TextSpan(
            text: nextWord == italicClosingTag ? word : '$word ',
            style: TextStyle(fontStyle: FontStyle.italic, fontSize: fontSize, height: lineSpacing),
          ),
        );
      } else {
        final finalWord =
            (nextWord == boldOpeningTag || nextWord == italicOpeningTag) ? word : '$word ';
        textSpans.add(
            TextSpan(text: finalWord, style: TextStyle(fontSize: fontSize, height: lineSpacing)));
      }
    }

    return textSpans;
  }
}
