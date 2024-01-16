import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:flutter/material.dart';

class Buttons extends StatelessWidget{
  BuildContext? context;
  dynamic onPressed; Widget? child;Color color = MyTheme.noColor;Alignment? alignment;EdgeInsetsGeometry padding=EdgeInsets.zero;double? width;double height;OutlinedBorder? shape;

  Buttons({Key? key,this.context, this.onPressed, this.child,this.color = MyTheme.noColor,this.alignment,this.padding=EdgeInsets.zero,this.width,this.height=5.0,this.shape}) : super(key: key);



  Widget _basic() {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        shape:shape,
        // maximumSize: width!=null?Size(width, height):null,
        minimumSize: width!=null?Size(width!, height):null,
        backgroundColor: color,
        alignment: alignment,
          padding: padding, elevation: 0.0, primary: MyTheme.black),
      child: child!,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return _basic();
  }


}
