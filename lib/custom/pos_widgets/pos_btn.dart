import 'package:flutter/cupertino.dart';

import '../../my_theme.dart';

class PosBtn extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color? color;
  final Color? textColor;
  final FontWeight? fontWeight;
  final VoidCallback? onTap;
  const PosBtn({
    Key? key,
    this.text = '--',
    this.icon,
    this.color,
    this.textColor = MyTheme.app_accent_color,
    this.fontWeight = FontWeight.normal,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        height: 36.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0),
          color: color,
          border: Border.all(
            width: 1.0,
            color: const Color(0xFFCFD9E1),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                text!,
                style: TextStyle(
                  fontSize: 13.0,
                  fontWeight: fontWeight,
                  color: textColor,
                  height: 1.23,
                ),
              ),
            ),
            if (icon != null)
              Icon(
                icon,
                size: 16.0,
              )
          ],
        ),
      ),
    );
  }
}
