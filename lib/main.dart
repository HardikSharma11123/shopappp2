import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

// used DevicePreview to check if app looks proper in different devices or not
void main() {
  runApp(
    ProviderScope(
      child: DevicePreview(
        enabled: true, //  Enable Device Preview
        builder: (context) => MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.white,
        scaffoldBackgroundColor: Color.fromRGBO(
          252,
          228,
          236,
          1,
        ), // ✅ Background color
        appBarTheme: AppBarTheme(
          backgroundColor: Color.fromRGBO(252, 228, 236, 1),
          elevation: 0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.black),
        ),
      ),
      home: HomePage(),
    );
  }
}
