import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;

class CScannerController {

  html.IFrameElement? _iframe;

  StreamSubscription? _messageSub;

  final StreamController<String> _onScan =
      StreamController<String>.broadcast();

  Stream<String> get onScan => _onScan.stream;

  void attachIframe(html.IFrameElement iframe) {

    _iframe = iframe;

    _messageSub?.cancel();

    _messageSub =
        html.window.onMessage.listen((event) {

      try {

        final data = event.data;

        final parsed =
            data is String
            ? jsonDecode(data)
            : data;

        if (parsed['type'] == 'scan') {

          final barcode =
              parsed['value'].toString();

          print("BARCODE: $barcode");

          _onScan.add(barcode);
        }

      } catch (e) {
        print("SCAN ERROR: $e");
      }
    });
  }

  void startScanner() {

    _iframe?.contentWindow?.postMessage(
      jsonEncode({
        'type': 'start',
      }),
      '*',
    );
  }

  void stopScanner() {

    _iframe?.contentWindow?.postMessage(
      jsonEncode({
        'type': 'stop',
      }),
      '*',
    );
  }

  void dispose() {

    _messageSub?.cancel();

    _onScan.close();
  }
}