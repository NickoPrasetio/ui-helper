//
//  empty_widget.dart
//  Inspire
//
//  Created by Vivekanandh Rao on 30/10/2023.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';

class EmptyWidget extends StatelessWidget {
  // Class Constructor
  const EmptyWidget({super.key});

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
