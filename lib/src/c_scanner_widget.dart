import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

 
import 'c_scanner_web.dart';
import 'c_scnner_controller.dart';

class CScannerWeb extends StatefulWidget {

  final CScannerController controller;

  const CScannerWeb({
    super.key,
    required this.controller,
  });

  @override
  State<CScannerWeb> createState() =>
      _CScannerWebState();
}

class _CScannerWebState
    extends State<CScannerWeb> {

  final String viewId =
      'scanner_${DateTime.now().microsecondsSinceEpoch}';

  bool isReady = false;

  @override
  void initState() {
    super.initState();

    initScanner();
  }

  Future<void> initScanner() async {

    final htmlContent =
        await rootBundle.loadString(
      'packages/c_barcodeweb/assets/scanner/scanner.html',
    );

    final iframe =
        registerScannerIframe(
      viewId,
      htmlContent,
    );

    widget.controller.attachIframe(
      iframe,
    );

    if (mounted) {
      setState(() {
        isReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    if (!isReady) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return HtmlElementView(
      viewType: viewId,
    );
  }
}