import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:kritproduct/models/read_data_model.dart';
import 'package:kritproduct/models/user_model.dart';

class ReadData extends StatefulWidget {

  final UserModel userModel;
  ReadData({Key key, this.userModel}) : super(key: key);

  @override
  _ReadDataState createState() => _ReadDataState();
}

class _ReadDataState extends State<ReadData> {

  // Field
  UserModel currentModel;
  String token, userID;
  List<ReadDataModel> readDataModels = List();

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

    http.Response response = await http.get(url, headers: headers);
    var result = json.decode(response.body);
    print('result ===>>> $result');

    var myResult = result['result'];
    print('myResult ===> $myResult');

    for (var myMap in myResult) {
      ReadDataModel readDataModel = ReadDataModel.fromJson(myMap);
      setState(() {
        readDataModels.add(readDataModel);
      });
    }

  }

  Widget showProcess(){
    return Center(child: CircularProgressIndicator(),);
  }

  Widget showListView(){
    return ListView.builder(itemBuilder: (BuildContext context, int index){
      return Text(readDataModels[index].fundNameT);
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fund'),
      ),
      body: readDataModels.length == 0 ? showProcess() : showListView() ,
    );
  }
}
