import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kritproduct/models/user_model.dart';
import 'package:kritproduct/widget/read_data.dart';


class Authen extends StatefulWidget {
  @override
  _AuthenState createState() => _AuthenState();
}

class _AuthenState extends State<Authen> {
  // Field
  String user, password;

  // Method
  Widget loginButton() {
    return RaisedButton(
      onPressed: () {
        if (user == null ||
            user.isEmpty ||
            password == null ||
            password.isEmpty) {
          print('########### Have Space ############');
        } else {
          checkAuthen();
        }
      },
      child: Text('Login'),
    );
  }

  Future<void> checkAuthen() async {
    String url = 'https://wr.wealthrepublic.co.th:3009/api/user/login';

    try {
      // // Dio Type
      Map<String, dynamic> map = Map();
      map['email'] = user;
      map['password'] = password;

      // Response response = await Dio().post(url, data: map);
      // print('response Status ====>>> ${response.statusCode}');

      // http Type
      Map<String, String> headers = Map();
      headers['Content-Type'] = 'application/json';

      // String jsonString = '{"email":"$user","password":"$password"}';

      var response = await http.post(url, body: map);
      // print('StatusCode ===>> ${response.statusCode}');

      if (response.statusCode == 401) {
        print('Login False');
      } else {
        var result = json.decode(response.body);

        // print('result = $result');

        UserModel userModel = UserModel.fromJson(result);

        MaterialPageRoute route = MaterialPageRoute(
            builder: (value) => ReadData(
                  userModel: userModel,
                ));
                Navigator.of(context).pushAndRemoveUntil(route, (value)=>false);
      }
    } catch (e) {
      print('ERRORRR ===>>> ${e.toString()}');
    }
  }

  Widget userForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (value) => user = value.trim(),
        decoration: InputDecoration(hintText: 'User :'),
      ),
    );
  }

  Widget passwordForm() {
    return Container(
      width: 250.0,
      child: TextField(
        onChanged: (value) => password = value.trim(),
        decoration: InputDecoration(hintText: 'Password :'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            userForm(),
            passwordForm(),
            loginButton(),
          ],
        ),
      ),
    );
  }
}
