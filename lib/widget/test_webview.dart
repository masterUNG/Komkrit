import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'package:http/http.dart';
import 'package:kritproduct/models/user_model.dart';

class TestWebView extends StatefulWidget {
  final UserModel userModel;
  TestWebView({Key key, this.userModel}) : super(key: key);

  @override
  _TestWebViewState createState() => _TestWebViewState();
}

class _TestWebViewState extends State<TestWebView> {
  // Field
  String url = 'https://m.wealthrepublic.co.th';
  UserModel currentModel;
  String token, userID;

  // Method
  @override
  void initState() {
    super.initState();
    currentModel = widget.userModel;
    token = currentModel.token;
    token = 'Bearer $token';
    userID = currentModel.uSERID;
    readData();
  }

  Future<void> readData() async {
    String url = 'https://wr.wealthrepublic.co.th:3009/api/wr/summary/$userID';

    Map<String, String> headers = Map();
    headers['Authorization'] = token;

    Response response = await get(url, headers: headers);
    var result = json.decode(response.body);
    print('result ===>>> $result');
  }

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
        actions: <Widget>[Text(currentModel.loginName)],
        title: Text('Test WebView'),
      ),
      body: showWebView(),
    );
  }
}
