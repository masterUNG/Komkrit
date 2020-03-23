import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class TestWebView extends StatefulWidget {
  @override
  _TestWebViewState createState() => _TestWebViewState();
}

class _TestWebViewState extends State<TestWebView> {
  // Field
  String url = 'https://m.wealthrepublic.co.th';

  // Method
  Widget showWebView() {
    return WebviewScaffold(
      url: url,
      hidden: true,
      withJavascript: true,

    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test WebView'),
      ),
      body: showWebView(),
    );
  }
}