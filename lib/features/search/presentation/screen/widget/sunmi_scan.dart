import 'package:flutter/material.dart';
import 'package:sunmi_scanner/sunmi_scanner.dart';

class SummiScan extends StatefulWidget {
  const SummiScan({super.key});

  @override
  State<SummiScan> createState() => _SummiScanState();
}

class _SummiScanState extends State<SummiScan> {
  String? scannedValue;

  void _setScannedValue(String value) {
    setState(() {
      scannedValue = value;
    });
  }

  @override
  void initState() {
    super.initState();
    SunmiScanner.onBarcodeScanned().listen((event) {
      _setScannedValue(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Column(
            children: [
              Center(
                child: Text(scannedValue ?? ""),
              ),
              InkWell(
                  onTap: () {
                    SunmiScanner.onBarcodeScanned().listen((event) {
                      _setScannedValue(event);
                    });
                  },
                  child: const Icon(Icons.camera, color: Colors.black)),
            ],
          ),
        ],
      ),
    );
  }
}
