//
//  retry_btn_with_msg_widget.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 18/05/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';

class AdaptiveBtnWithMsgWidget extends StatelessWidget {
  // Properties
  final String message;
  final String btnTitle;
  final VoidCallback onTap;

  // Class Constructor
  const AdaptiveBtnWithMsgWidget({
    super.key,
    required this.message,
    required this.btnTitle,
    required this.onTap,
  });

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AdaptiveText(text: message, textAlign: TextAlign.center),
          const SizedBox(height: 16),
          SizedBox(
            width: 100,
            child: AdaptiveButton(
              titleText: btnTitle,
              fontSize: UIFont.h6,
              onTap: onTap,
              padding: const EdgeInsets.all(4),
            ),
          )
        ],
      ),
    );
  }
}
