import 'package:active_ecommerce_seller_app/custom/aiz_typedef.dart';
import 'package:active_ecommerce_seller_app/repositories/pos_repository.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../../my_theme.dart';
import '../my_widget.dart';
import '../toast_component.dart';

class PosProductListWidget extends StatefulWidget {
  final String? productName;
  int cartId;
  final String? price;
  final String? image;
  final String? stock;
  int minQty;
  futureVoid updateCart;
  futureVoid deleteCart;
  var cartQty;

  PosProductListWidget({
    this.price,
    this.productName,
    required this.cartId,
    required this.updateCart,
    required this.deleteCart,
    this.image,
    this.stock,
    this.cartQty,
    required this.minQty,
    super.key,
  });

  @override
  State<PosProductListWidget> createState() => _PosProductListWidgetState();
}

class _PosProductListWidgetState extends State<PosProductListWidget> {
  var localCartQty;

  increment() {
    localCartQty += 1;
    widget.cartQty = localCartQty;

    updateCartItem();
    setState(() {});
  }

  decrement() {
    if (localCartQty == widget.minQty) {
      return;
    }
    localCartQty -= 1;
    widget.cartQty = localCartQty;
    updateCartItem();
    setState(() {});
  }

  deleteCartItem() async {
    var response = await PosRepository().deleteCartData(widget.cartId);

    if (response.result!) {
      widget.deleteCart();
    }
  }

  updateCartItem() async {
    var response =
        await PosRepository().updateCartData(widget.cartId, localCartQty);
    if (response.result!) {
      widget.updateCart();
    }
    // show message
    ToastComponent.showDialog(response.message!,
        bgColor: MyTheme.white,
        duration: Toast.lengthLong,
        gravity: Toast.center);
  }

  @override
  void initState() {
    // TODO: implement initState
    localCartQty = int.parse(widget.cartQty);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MyWidget.customCardView(
        elevation: 5,
        backgroundColor: MyTheme.white,
        height: 90,
        width: double.infinity,
        borderColor: MyTheme.light_grey,
        borderRadius: 6,
        margin: const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          children: [
            MyWidget.imageWithPlaceholder(
              width: 84.0,
              height: 90.0,
              fit: BoxFit.cover,
              url: "imageUrl",
              radius: const BorderRadius.only(
                topLeft: Radius.circular(5),
                bottomLeft: Radius.circular(5),
              ),
            ),
            Expanded(
              flex: 4,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.productName!,
                      maxLines: 2,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: MyTheme.app_accent_color,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.price!,
                          style: const TextStyle(
                            color: MyTheme.app_accent_color,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            deleteCartItem();
                          },
                          child: SizedBox(
                            height: 17,
                            width: 17,
                            child: Image.asset(
                              'assets/icon/delete.png',
                              color: MyTheme.app_accent_color,
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () => increment(),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/icon/increment.png',
                        ),
                      ),
                    ),
                    Text("${widget.cartQty}"),
                    GestureDetector(
                      onTap: () => decrement(),
                      child: SizedBox(
                        height: 20,
                        width: 20,
                        child: Image.asset(
                          'assets/icon/decrement.png',
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
