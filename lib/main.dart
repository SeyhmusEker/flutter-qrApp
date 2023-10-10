import 'package:flutter/material.dart';
import 'package:qr_app/pages/home_page.dart';

void main() {
  runApp(QrApp());
}

class QrApp extends StatelessWidget {
  const QrApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: HomePageScreen(),
      ),
    );
  }
}
