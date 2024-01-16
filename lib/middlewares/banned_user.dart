import 'dart:convert';
import 'package:active_ecommerce_seller_app/helpers/auth_helper.dart';
import 'package:active_ecommerce_seller_app/screens/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one_context/one_context.dart';
import 'middleware.dart';

class BannedUser extends Middleware<bool, http.Response> {
  @override
  bool next(http.Response response) {
    var jsonData = jsonDecode(response.body);
    if (jsonData.runtimeType != List &&
        jsonData.containsKey("result") &&
        !jsonData['result']) {
      if (jsonData.containsKey("status") && jsonData['status'] == "banned") {
        AuthHelper().clearUserData();
        Navigator.pushAndRemoveUntil(OneContext().context!,
            MaterialPageRoute(builder: (context) => Main()), (route) => false);
        return false;
      }
    }
    return true;
  }
}
