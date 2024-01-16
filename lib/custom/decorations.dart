


import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:flutter/cupertino.dart';

class MDecoration{
  static BoxDecoration decoration1({double radius =6.0 ,bool showShadow=true}) {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
      color: MyTheme.white,
      boxShadow: [
        showShadow?BoxShadow(
          color: MyTheme.black.withOpacity(0.15),
          blurRadius: 20,
          spreadRadius: 0.0,
          offset: const Offset(0.0, 10.0), // shadow direction: bottom right
        ):const BoxShadow()
      ],
    );
  }



}