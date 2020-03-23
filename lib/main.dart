import 'package:flutter/material.dart';
import 'package:kritproduct/widget/test_webview.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: TestWebView(),
    );
  }
}