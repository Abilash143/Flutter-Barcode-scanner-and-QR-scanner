import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _scanBarcode = 'Unknown';

  @override
  void initState() {
    super.initState();
  }

  //Continuous BarCode scanning operation
  startBarcodeScanStream() async {
    FlutterBarcodeScanner.getBarcodeStreamReceiver(
            "#ff6666", "Cancel", true, ScanMode.BARCODE)
        .listen((barcode) => print(barcode));
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> scanBarcodeNormal() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
                title: Text(
              "Barcode scanner",
              style: GoogleFonts.roboto(),
            )),
            body: Builder(builder: (BuildContext context) {
              return Container(
                  color: Colors.blueGrey[50],
                  alignment: Alignment.center,
                  child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RaisedButton(
                            color: Colors.blue,
                            onPressed: () => scanBarcodeNormal(),
                            child: Text("Start barcode scan",
                                style:
                                    GoogleFonts.roboto(color: Colors.white))),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                            color: Colors.blue,
                            onPressed: () => scanQR(),
                            child: Text("Start QR scan",
                                style:
                                    GoogleFonts.roboto(color: Colors.white))),
                        SizedBox(
                          height: 10,
                        ),
                        RaisedButton(
                            color: Colors.blue,
                            onPressed: () => startBarcodeScanStream(),
                            child: Text("Start barcode scan stream",
                                style:
                                    GoogleFonts.roboto(color: Colors.white))),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          margin: EdgeInsets.all(10),
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Text(
                              'Scan result : $_scanBarcode',
                              style: GoogleFonts.roboto(fontSize: 17),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        // Text('Scan result : $_scanBarcode\n',
                        //     style: TextStyle(fontSize: 20))
                      ]));
            })));
  }
}
