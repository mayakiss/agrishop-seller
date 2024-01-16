import 'package:flutter/material.dart';

import '../../my_theme.dart';
import '../my_widget.dart';

class PosItemCard extends StatelessWidget {
  final String? name;
  final String? thumbnailImage;
  final int? stock;
  final String? price;
  final int? qty;

  const PosItemCard({
    Key? key,
    this.name,
    this.thumbnailImage,
    this.stock,
    this.price,
    this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: Stack(children: [
        Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(6),
                    topRight: Radius.circular(6),
                  ),
                ),
                height: 104,
                width: double.infinity,
                child: MyWidget.imageWithPlaceholder(
                  width: 84.0,
                  height: 90.0,
                  fit: BoxFit.cover,
                  url: thumbnailImage,
                  radius: const BorderRadius.only(
                    topLeft: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                decoration: BoxDecoration(
                  color: MyTheme.app_accent_color_extra_light,
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(6),
                      bottomLeft: Radius.circular(6)),
                ),
                height: 60,
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name!,
                      style: const TextStyle(
                          fontSize: 12,
                          color: MyTheme.font_grey,
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      price!,
                      style: const TextStyle(
                          fontSize: 12,
                          color: MyTheme.font_grey,
                          fontWeight: FontWeight.w400),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
            child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: const BoxDecoration(
            color: MyTheme.app_accent_color,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6),
              bottomRight: Radius.circular(6),
            ),
          ),
          child: Text(
            qty.toString(),
            style: TextStyle(fontSize: 12, color: MyTheme.white),
          ),
        ))
      ]),
    );
  }
}
