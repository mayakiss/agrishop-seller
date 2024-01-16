import 'package:active_ecommerce_seller_app/custom/common_style.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:flutter/material.dart';

class MyAppBar {
  bool? centerTitle = false;
  String? title;
  BuildContext? context;
  PreferredSizeWidget? bottom;

  MyAppBar({this.title, this.context, this.centerTitle, this.bottom});

  AppBar show({var elevation = 5.0}) {
    return AppBar(
      bottom: bottom,
      leadingWidth: 0.0,
      centerTitle: centerTitle,
      elevation: elevation,
      title: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            child: IconButton(
              splashRadius: 15,
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pop(context!);
              },
              icon: Image.asset(
                'assets/icon/back_arrow.png',
                height: 20,
                width: 20,
                color: MyTheme.app_accent_color,
                //color: MyTheme.dark_grey,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title!,
            style: MyTextStyle().appbarText(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      /*leading:Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(

          iconSize: 20,
          splashRadius: 15,
          padding: EdgeInsets.zero,
            onPressed: (){
          Navigator.pop(context);
        }, icon: Image.asset(
          'assets/icon/back_arrow.png',
          height: 20,
          width: 20,
          //color: MyTheme.dark_grey,
        ),),
      ),*/
    );
  }

  AppBar copyWithBottom(
      {var elevation = 5.0,
      Widget bottom = const SizedBox(
        height: 0,
        width: 0,
      ),
      Size size = const Size(0, 0)}) {
    return AppBar(
      leadingWidth: 0.0,
      centerTitle: centerTitle,
      elevation: elevation,
      title: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            child: IconButton(
              splashRadius: 15,
              padding: EdgeInsets.all(0.0),
              onPressed: () {
                Navigator.pop(context!);
              },
              icon: Image.asset(
                'assets/icon/back_arrow.png',
                height: 20,
                width: 20,
                color: MyTheme.app_accent_color,
                //color: MyTheme.dark_grey,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Text(
            title!,
            style: MyTextStyle().appbarText(),
          ),
        ],
      ),
      backgroundColor: Colors.white,
      bottom: PreferredSize(
        child: bottom,
        preferredSize: size,
      ),
      /*leading:Container(
        margin: EdgeInsets.only(left: 10),
        child: IconButton(

          iconSize: 20,
          splashRadius: 15,
          padding: EdgeInsets.zero,
            onPressed: (){
          Navigator.pop(context);
        }, icon: Image.asset(
          'assets/icon/back_arrow.png',
          height: 20,
          width: 20,
          //color: MyTheme.dark_grey,
        ),),
      ),*/
    );
  }
}
