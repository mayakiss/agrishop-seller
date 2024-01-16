import 'package:flutter/material.dart';

import '../../my_theme.dart';

class PosCustomerInfoRow extends StatelessWidget {
  final String? title;
  final String? content;
  final bool? check;

  const PosCustomerInfoRow({
    Key? key,
    this.title = "--",
    this.content = "--",
    this.check = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 12.0,
                color: MyTheme.font_grey,
                height: 1.23,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              content ?? "",
              maxLines: 2,
              style: const TextStyle(
                fontSize: 12.0,
                color: MyTheme.font_grey,
                fontWeight: FontWeight.w700,
                height: 1.23,
              ),
              textAlign: TextAlign.right,
            ),
          ),
          // Expanded(
          //   flex: 1,
          //   child: buildShippingOptionsCheckContainer(check!),
          // ),
        ],
      ),
    );
  }

  Widget buildShippingOptionsCheckContainer(bool check) {
    return check
        ? Container(
            height: 16,
            width: 16,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.0), color: Colors.green),
            child: const Padding(
              padding: EdgeInsets.all(3),
              child: Icon(Icons.check, color: Colors.white, size: 10),
            ),
          )
        : Container();
  }
}
