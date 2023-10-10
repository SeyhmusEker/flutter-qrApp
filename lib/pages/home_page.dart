import 'package:flutter/material.dart';
import 'package:qr_app/constants/const.dart';
import 'package:qr_app/pages/scanner_page.dart';
import 'package:qr_app/themes/theme.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  late Size size;
  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: ThemeManager.OnlyTheme.scaffoldBackgroundColor,
      appBar: Constants.customAppBar,
      body: Container(
        width: size.width,
        height: size.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScannerPage(),
                      ));
                },
                child: Text("QR KODU TARA"),
                style: ElevatedButton.styleFrom(
                    elevation: 0,
                    backgroundColor: ThemeManager.OnlyTheme.iconTheme.color,
                    shape: StadiumBorder(),
                    shadowColor: ThemeManager.OnlyTheme.iconTheme.color),
              ),
            )
          ],
        ),
      ),
    );
  }
}
