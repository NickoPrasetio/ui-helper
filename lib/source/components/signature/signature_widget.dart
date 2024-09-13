//
//  signature_widget.dart
//  Allianz
//
//  Created by Vivekanandh Rao on 06/05/2024.
//  Copyright © 2023 Allianz. All rights reserved.
//

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ui_helper/flutter_ui_helper.dart';
import 'package:flutter_ui_helper/source/components/signature/signature_canvas_widget.dart';

class SignatureWidget extends StatefulWidget {
  // Properties
  final double width;
  final double height;
  final void Function(Image?, ByteData?) onDone;

  // Class Constructor
  const SignatureWidget({
    super.key,
    required this.onDone,
    this.width = 300,
    this.height = 300,
  });

  @override
  State<SignatureWidget> createState() => _SignatureWidgetState();
}

class _SignatureWidgetState extends State<SignatureWidget> {
  Image? _signature;

  // Widget Methods
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final langCode = Localizations.localeOf(context).languageCode;
    final signaturePlaceHolderPath = langCode == 'id'
        ? HelperConstant.signaturePlaceHolderID
        : HelperConstant.signaturePlaceHolderEN;

    return AdaptiveTapGesture(
      onTap: () {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return PopScope(
              canPop: false,
              child: Dialog(
                insetPadding:
                    Device.isMediumScreenAndAbove(context) ? const EdgeInsets.all(16) : null,
                shape: RoundedRectangleBorder(
                  borderRadius: Device.isMediumScreenAndAbove(context)
                      ? BorderRadius.circular(20.0)
                      : BorderRadius.circular(0.0),
                ),
                backgroundColor: ColorPalette.bgColor,
                surfaceTintColor: Colors.transparent,
                child: SizedBox(
                  height: 600,
                  child: SignatureCanvasWidget(
                    onDone: (signatureImage, signatureByteData) {
                      widget.onDone(signatureImage, signatureByteData);
                      Navigator.of(context).pop();
                      setState(() {
                        _signature = signatureImage ?? _signature;
                      });
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: widget.width,
        height: widget.height,
        decoration: HelperConstant.getBorderBoxDecoration(),
        child: _signature ?? Image.asset(signaturePlaceHolderPath),
      ),
    );
  }
}
