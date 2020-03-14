import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_qr_reader/qrcode_reader_view.dart';

class QRScanView extends StatefulWidget {
  QRScanView({Key key}) : super(key: key);

  @override
  _QRScanViewState createState() => new _QRScanViewState();
}

class _QRScanViewState extends State<QRScanView> {
  GlobalKey<QrcodeReaderViewState> _key = GlobalKey();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: QrcodeReaderView(
        key: _key,
        onScan: onScan,
        headerWidget: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
      ),
    );
  }

  Future onScan(String data) async {
    Navigator.of(context).pop(data);
  }

  @override
  void dispose() {
    super.dispose();
  }
}