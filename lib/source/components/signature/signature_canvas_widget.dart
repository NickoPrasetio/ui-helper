//
//  signature_canvas_widget.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 06/05/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'dart:math';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_ui_helper/source/components/buttons/adaptive_button.dart';
import 'package:flutter_ui_helper/source/components/signature/signature_painter.dart';
import 'package:flutter_ui_helper/source/constant/helper_constant.dart';

class SignatureCanvasWidget extends StatefulWidget {
  // Properties
  final void Function(Image?, ByteData?) onDone;

  // Class Constructor
  const SignatureCanvasWidget({super.key, required this.onDone});

  // Widget State
  @override
  State<SignatureCanvasWidget> createState() => _SignatureCanvasState();
}

class _SignatureCanvasState extends State<SignatureCanvasWidget> {
  // State Properties
  final List<List<Offset>> _signatures = [];

  // Widget Methods
  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final clearBtnTitle = langCode == 'id' ? 'Hapus' : 'Clear';
    final doneBtnTitle = langCode == 'id' ? 'Selesai' : 'Done';
    return Column(
      children: [
        Expanded(
          child: Container(
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
            decoration: HelperConstant.getBorderBoxDecoration(),
            child: GestureDetector(
              onPanStart: (details) {
                _signatures.add([]);
              },
              onPanUpdate: (DragUpdateDetails details) {
                setState(() {
                  RenderBox renderBox = context.findRenderObject() as RenderBox;
                  Offset localPosition = renderBox.globalToLocal(details.globalPosition);
                  _signatures.last.add(localPosition);
                });
              },
              child: ClipRect(
                child: CustomPaint(
                  painter: SignaturePainter(_signatures),
                  size: Size.infinite,
                  child: const SizedBox(
                    width: double.infinity,
                    height: 600,
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(
                width: 100,
                child: AdaptiveButton(
                  buttonType: AdaptiveButtonType.blackButton,
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                  titleText: clearBtnTitle,
                  onTap: () {
                    setState(() {
                      _signatures.clear();
                    });
                  },
                ),
              ),
              const SizedBox(width: 16),
              SizedBox(
                width: 100,
                child: AdaptiveButton(
                  padding: const EdgeInsets.only(top: 8, bottom: 8, left: 16, right: 16),
                  titleText: doneBtnTitle,
                  onTap: () async {
                    Image? signatureImage;
                    final byteData = await _captureSignature();
                    if (byteData != null) {
                      Uint8List uint8list = byteData.buffer.asUint8List();
                      signatureImage = Image.memory(uint8list);
                    }

                    widget.onDone(signatureImage, byteData);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Future<ByteData?> _captureSignature() async {
    if (_signatures.isEmpty) {
      return null;
    }

    Rect signatureBounds = _calculateSignatureBounds();
    double padding = 50.0;
    Rect paddedBounds = Rect.fromLTRB(
      signatureBounds.left - padding,
      signatureBounds.top - padding,
      signatureBounds.right + padding,
      signatureBounds.bottom + padding,
    );

    double width = paddedBounds.width;
    double height = paddedBounds.height;
    double maxSize = width > height ? width : height;
    width = maxSize;
    height = maxSize;

    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    canvas.translate(-paddedBounds.left + (width - paddedBounds.width) / 2,
        -paddedBounds.top + (height - paddedBounds.height) / 2);
    canvas.clipRect(paddedBounds);
    SignaturePainter(_signatures).paint(canvas, paddedBounds.size);
    final picture = recorder.endRecording();

    final img = await picture.toImage(width.toInt(), height.toInt());
    return await img.toByteData(format: ui.ImageByteFormat.png);
  }

  Rect _calculateSignatureBounds() {
    if (_signatures.isEmpty) {
      return Rect.zero;
    }

    double minX = double.infinity;
    double minY = double.infinity;
    double maxX = double.negativeInfinity;
    double maxY = double.negativeInfinity;

    for (final signature in _signatures) {
      for (final point in signature) {
        minX = min(minX, point.dx);
        minY = min(minY, point.dy);
        maxX = max(maxX, point.dx);
        maxY = max(maxY, point.dy);
      }
    }

    return Rect.fromLTRB(minX, minY, maxX, maxY);
  }
}
