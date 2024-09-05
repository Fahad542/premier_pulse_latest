import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvvm/res/app_url.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../model/branch_model.dart';
import 'authentication and base_url.dart';


class branch_Repository {
  Future<List<Branch_compnay>> team_company_fetchData() async {
    try {
      var connectivityResult = await Connectivity().checkConnectivity();
      if (connectivityResult == ConnectivityResult.none) {
        Fluttertoast.showToast(
          msg: "No Internet Connection",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        throw Exception('No Internet Connection');
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String username = prefs.getString('username') ?? '';
      String password = prefs.getString('password') ?? '';
      final authCredentials = AuthCredentials(username, password);
      final response = await http.post(
        Uri.parse(AppUrl.branches),

        headers: {
          'Content-Type': 'application/json',
          'Authorization': authCredentials.basicAuth
        },
      );

      print(AppUrl.company);


      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        print(data);

        return List<Branch_compnay>.from(data.map((json) => Branch_compnay.fromJson(json)));
      } else {
        print('Error - Status Code: ${response.statusCode}');
        print('Error - Body: ${response.body}');
        throw Exception('Failed to load data. Server returned status ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load data. $e');
    }
  }
}

