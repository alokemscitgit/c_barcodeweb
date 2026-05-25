import 'package:c_barcodeweb/src/c_scanner_widget.dart';
import 'package:flutter/material.dart';

import 'src/c_scnner_controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Scanner(),
    );
  }
}

class Scanner extends StatefulWidget {
  const Scanner({super.key});

  @override
  State<Scanner> createState() => _ScannerState();
}

class _ScannerState extends State<Scanner> {
  final controller = CScannerController();
  var  str = '';
  @override
  void initState() {
    super.initState();

    controller.onScan.listen((barcode) {
      print(barcode);
      setState(() {
        str = barcode;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [Expanded(child: CScannerWeb(controller: controller)), 
      SizedBox(height: 40,),
      Text(str)],
    );
  }
}
