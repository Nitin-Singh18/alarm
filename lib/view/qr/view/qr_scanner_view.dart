import 'package:flutter/material.dart';

class QRScannerView extends StatefulWidget {
  const QRScannerView({super.key});

  @override
  State<QRScannerView> createState() => _QRScannerViewState();
}

class _QRScannerViewState extends State<QRScannerView> {
  // final MobileScannerController _scannerController = MobileScannerController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: 300,
                  width: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(width: 4),
                  ),
                  child: const SizedBox(
                    height: 10,
                    width: 10,
                  )
                  // MobileScanner(
                  //   controller: _scannerController,
                  //   onDetect: (BarcodeCapture code) {},
                  // ),
                  ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                'Place your camera on QR code',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
