import 'dart:html' as html;
import 'dart:ui_web' as ui_web;

html.IFrameElement registerScannerIframe(
  String viewId,
  String htmlContent,
) {

  final iframe = html.IFrameElement()
    ..srcdoc = htmlContent
    ..style.border = 'none'
    ..style.width = '100%'
    ..style.height = '100%';

  ui_web.platformViewRegistry.registerViewFactory(
    viewId,
    (int viewId) => iframe,
  );

  return iframe;
}