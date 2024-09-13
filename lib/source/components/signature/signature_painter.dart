//
//  signature_painter.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 06/05/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/material.dart';

class SignaturePainter extends CustomPainter {
  // Properties
  final List<List<Offset>> signatures;

  // Class Constructor
  SignaturePainter(this.signatures);

  // Widget Methods
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;

    for (final signature in signatures) {
      for (int i = 0; i < signature.length - 1; i++) {
        canvas.drawLine(signature[i], signature[i + 1], paint);
      }
    }
  }

  @override
  bool shouldRepaint(SignaturePainter oldDelegate) => true;
}
