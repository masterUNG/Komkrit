import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:kritproduct/models/read_data_model.dart';
import 'package:kritproduct/models/result_model.dart';
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
  List<ResultModel> resultModels = List();

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

    var myResult = json.decode(response.body)['result'];
    // print('myResult = $myResult');

    for (var map in myResult) {
      // print('map ===>> $map');

      ResultModel resultModel = ResultModel.fromJson(map);
      // print('AvgCode ===>>> ${resultModel.avgCost}');
      setState(() {
        resultModels.add(resultModel);
      });
      print('resultModels.lenght ===>>>  ${resultModels.length}');
    }
  }

  Widget showProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showContent(int index) {
    return Card(
      child: Column(
        children: <Widget>[
          showAmcName(index),
          showBaanceUnit(index),
          Text(resultModels[index].avgCost.toString()),
          Text(resultModels[index].avgCostUnit.toString()),
        ],
      ),
    );
  }

  Widget showBaanceUnit(int index) {
    double balanceUnit = resultModels[index].balanceUnit;
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Text(
          myFormat(balanceUnit, 'BalanceUnit ='),
        ),
      ],
    );
  }

  String myFormat(double myDouble, String title) {
    
    NumberFormat numberFormat = NumberFormat('#,###.####');
    return numberFormat.format(myDouble);

    // return '$title ${myDouble.toStringAsFixed(myDouble.truncateToDouble() == myDouble ? 0 : 2)}';

  }

  Widget showAmcName(int index) => Row(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width - 10,
            child: Text(
              resultModels[index].amcName,
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      );

  Widget showListView() {
    return ListView.builder(
      itemCount: resultModels.length,
      itemBuilder: (BuildContext context, int index) {
        return showContent(index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fund'),
      ),
      body: resultModels.length == 0 ? showProcess() : showListView(),
    );
  }
}
