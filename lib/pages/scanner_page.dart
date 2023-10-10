import 'package:flutter/material.dart';
import 'package:qr_app/constants/const.dart';
import 'package:qr_app/themes/theme.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannerPage extends StatefulWidget {
  const ScannerPage({super.key});

  @override
  State<ScannerPage> createState() => _ScannerPageState();
}

class _ScannerPageState extends State<ScannerPage> {
  late Size size;
  final GlobalKey _qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? _controller;
  Barcode? result;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    _controller?.pauseCamera();
    _controller?.resumeCamera();

    return Scaffold(
      appBar: Constants.customAppBar,
      body: Container(
        height: size.height,
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              flex: 9,
              child: _buildQrView(context),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Color(0xffe3dfdf),
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        await _controller?.toggleFlash();
                      },
                      child: Icon(
                        Icons.flash_on,
                        size: 24,
                        color: Color(0xffF7524F),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        await _controller?.flipCamera();
                      },
                      child: Icon(
                        Icons.flip_camera_ios,
                        size: 24,
                        color: Color(0xffF7524F),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    var scanArea = 250.0;

    return QRView(
      key: _qrKey,
      onQRViewCreated: _onQRViewCreated,
      onPermissionSet: (ctrl, p) => onPermissionSet(context, ctrl, p),
      overlay: QrScannerOverlayShape(
        cutOutSize: scanArea,
        borderWidth: 10,
        borderLength: 40,
        borderRadius: 5.0,
        borderColor: Color(0xffF7524F),
      ),
    );
  }

  void _onQRViewCreated(QRViewController _qrController) {
    setState(() {
      this._controller = _qrController;
    });
    _controller?.scannedDataStream.listen((event) {
      setState(() {
        result = event;
        _controller?.pauseCamera();
      });
      if (result?.code != null) {
        _goWebSite();
      }
    });
  }

  void onPermissionSet(
      BuildContext context, QRViewController _ctrl, bool _permission) {
    if (!_permission) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("İzin Yok"),
      ));
    }
  }

  Widget _goWebSite() {
    return Center(
        child: FutureBuilder<dynamic>(
      future: showDialog(
        context: context,
        builder: (BuildContext context) {
          return WillPopScope(
            child: AlertDialog(
              title: Text("Link"),
              content: SizedBox(
                height: 200,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      result!.code.toString(), //LİNK
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        _launchURL(result!.code.toString());
                      },
                      child: Text("Linke Git"),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              ThemeManager.OnlyTheme.iconTheme.color,
                          shape: StadiumBorder(),
                          shadowColor: ThemeManager.OnlyTheme.iconTheme.color),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text("Geri Çık"),
                      style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor:
                              ThemeManager.OnlyTheme.iconTheme.color,
                          shape: StadiumBorder(),
                          shadowColor: ThemeManager.OnlyTheme.iconTheme.color),
                    ),
                  ],
                ),
              ),
            ),
            onWillPop: () async {
              Navigator.pop(context);
              return true;
            },
          ); //Telefonun Geri tuşu
        },
        barrierDismissible: false,
      ),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        throw UnimplementedError;
      },
    ));
  }

  _launchURL(var _uri) async {
    Uri _url = Uri.parse(_uri);
    if (await launchUrl(_url)) {
    } else {
      throw 'Could not launch $_url';
    }
  }
}
