import 'dart:convert';
import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/middlewares/middleware.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:one_context/one_context.dart';

class MaintenanceMiddleware extends Middleware<bool, http.Response> {
  @override
  bool next(http.Response response) {
    try {
      var jsonData = jsonDecode(response.body);
      if (jsonData.runtimeType != List &&
          jsonData['result'] != null &&
          !jsonData['result']) {
        if (jsonData.containsKey("status") &&
            jsonData['status'] == "maintenance") {
          OneContext().addOverlay(
              overlayId: "maintenance",
              builder: (context) => Scaffold(
                    body: Container(
                      padding: EdgeInsets.symmetric(horizontal: 24),
                      height: DeviceInfo(context).getHeight(),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "assets/img/maintenance.png",
                            ),
                            SizedBox(
                              height: 14,
                            ),
                            Text(
                              jsonData['message'],
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: MyTheme.font_grey),
                            )
                          ]),
                    ),
                  ));
          return false;
        }
      }
    } on Exception catch (e) {
      // TODO
    }
    return true;
  }
}
