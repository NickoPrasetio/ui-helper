//
//  rtf_viewer_widget.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 23/04/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class RTFViewerWidget extends StatefulWidget {
  // Properties
  final ScrollController scrollController;
  final String rtfAssetPath;
  final Map<String, String> replacements;

  // Class Constructor
  const RTFViewerWidget({
    super.key,
    required this.scrollController,
    required this.rtfAssetPath,
    this.replacements = const {},
  });

  // Widget State
  @override
  State<RTFViewerWidget> createState() => _RTFViewerWidgetState();
}

class _RTFViewerWidgetState extends State<RTFViewerWidget> {
  late Future<String> _rtfContent;

  // Widget Methods
  @override
  void initState() {
    super.initState();
    _rtfContent = _loadRTFAsset();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _rtfContent,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return const Center(child: Text('Error loading RTF file'));
        } else {
          return StringTextViewerWidget(
            content: snapshot.data ?? '',
            scrollController: widget.scrollController,
          );
        }
      },
    );
  }

  // Object Level Private Methods
  Future<String> _loadRTFAsset() async {
    return await rootBundle.loadString(widget.rtfAssetPath);
  }
}
