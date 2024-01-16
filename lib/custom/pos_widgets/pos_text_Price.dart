import 'package:flutter/cupertino.dart';

class PosTextPrice extends StatelessWidget {
  final String? title;
  final String? price;

  const PosTextPrice({
    Key? key,
    this.price = '0.00',
    this.title = '--',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Text(
              title!,
              style: const TextStyle(
                fontSize: 13.0,
                color: Color(0xFF2E294E),
                fontWeight: FontWeight.w700,
                height: 1.23,
              ),
            ),
          ),
          Text(
            '$price',
            style: const TextStyle(
              fontSize: 13.0,
              color: Color(0xFF2E294E),
              fontWeight: FontWeight.w700,
              height: 1.23,
            ),
            textAlign: TextAlign.right,
          ),
        ],
      ),
    );
  }
}
