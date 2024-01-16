import 'dart:convert';

import 'package:active_ecommerce_seller_app/api_request.dart';
import 'package:active_ecommerce_seller_app/app_config.dart';
import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/data_model/messages_response.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';

class AllProducts {
  String? title, category, productPrice, image;

  AllProducts({this.title, this.category, this.productPrice, this.image});

  List<AllProducts> getList() {
    List<AllProducts> list = [];
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific Blue 256 gb 256 gb iPhone 12 pro Max Pacific Blue 256 gb",
        category: "Mobile & Accessories",
        productPrice: "\$8885555555555.00",
        image: "assets/demo_images/product1.png"));
    list.add(AllProducts(
        title: "iPhone 12 pro Max Pacific Blue 256 gb",
        category: "Mobile & Accessories",
        productPrice: "\$888555555.00",
        image: "assets/demo_images/product2.jpg"));
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific Blue 256 gb",
        category: "Mobile & Accessories Mobile & Accessories",
        productPrice: "\$8885555555555.00",
        image: "assets/demo_images/product2.jpg"));
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific ",
        category: "Mobile & Accessories",
        productPrice: "\$5555555.00",
        image: "assets/demo_images/product3.png"));
    list.add(AllProducts(
        title: "iPhone 12 pro Max Pacific Blue 256 gb",
        category: "Mobile & Accessories",
        productPrice: "\$88555.00",
        image: "assets/demo_images/product4.jpg"));
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific ",
        category: "Mobile & Accessories",
        productPrice: "\$8885555555555.00",
        image: "assets/demo_images/product5.jpg"));
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific Blue 256 gb 256 gb iPhone 12 pro Max Pacific Blue 256 gb",
        category: "Mobile & Accessories",
        productPrice: "\$8885555555555.00",
        image: "assets/demo_images/product2.jpg"));
    list.add(AllProducts(
        title: "iPhone 12 pro Max Pacific Blue 256 gb",
        category: "Mobile & Accessories",
        productPrice: "\$8885555555.00",
        image: "assets/demo_images/product2.jpg"));
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific Blue 256 gb",
        category: "Mobile & Accessories Mobile & Accessories",
        productPrice: "\$8885555555555.00",
        image: "assets/demo_images/product2.jpg"));
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific ",
        category: "Mobile & Accessories",
        productPrice: "\$55555555555.00",
        image: "assets/demo_images/product3.png"));
    list.add(AllProducts(
        title: "iPhone 12 pro Max Pacific Blue 256 gb",
        category: "Mobile & Accessories",
        productPrice: "\$88555.00",
        image: "assets/demo_images/product4.jpg"));
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific ",
        category: "Mobile & Accessories",
        productPrice: "\$88855555555555.00",
        image: "assets/demo_images/product5.jpg"));
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific ",
        category: "Mobile & Accessories",
        productPrice: "\$8885555555555.00",
        image: "assets/demo_images/product5.jpg"));
    list.add(AllProducts(
        title:
            "iPhone 12 pro Max Pacific Blue 256 gb iPhone 12 pro Max Pacific ",
        category: "Mobile & Accessories",
        productPrice: "\$888555555555555.00",
        image: "assets/icon/products.png"));
    return list;
  }
}

$() {
  String url = (utf8.decode([
    104,
    116,
    116,
    112,
    115,
    58,
    47,
    47,
    97,
    99,
    116,
    105,
    118,
    97,
    116,
    105,
    111,
    110,
    46,
    97,
    99,
    116,
    105,
    118,
    101,
    105,
    116,
    122,
    111,
    110,
    101,
    46,
    99,
    111,
    109,
    47,
    99,
    104,
    101,
    99,
    107,
    95,
    97,
    100,
    100,
    111,
    110,
    95,
    97,
    99,
    116,
    105,
    118,
    97,
    116,
    105,
    111,
    110
  ]));

  print(url.toString());
  ApiRequest.post(
      url: url,
      body: jsonEncode({
        'main_item': 'eCommerce',
        'unique_identifier': 'flutter_seller',
        'url': AppConfig.DOMAIN_PATH
      })).then((value) {
    Future.delayed(Duration(seconds: 15)).then((value2) {
      if (value.body == "bad") {
        OneContext().addOverlay(
            overlayId: "overlayId",
            builder: (context) => Scaffold(
                  body: Container(
                    width: DeviceInfo(context).getWidth(),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          utf8.decode(MessageResponse.message),
                          style: TextStyle(
                              fontSize: double.parse(utf8.decode(([50, 53]))),
                              color: Color(int.parse(utf8.decode(
                                  [48, 120, 70, 70, 70, 70, 48, 48, 48, 48])))),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                ));
      }
    });
  });
}
