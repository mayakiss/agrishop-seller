import 'package:active_ecommerce_seller_app/custom/buttons.dart';
import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:active_ecommerce_seller_app/custom/my_widget.dart';
import 'package:active_ecommerce_seller_app/custom/route_transaction.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/helpers/shop_info_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/auth_repository.dart';
import 'package:active_ecommerce_seller_app/repositories/shop_repository.dart';
import 'package:active_ecommerce_seller_app/screens/auction/auction_order.dart';
import 'package:active_ecommerce_seller_app/screens/change_language.dart';
import 'package:active_ecommerce_seller_app/screens/commission_history.dart';
import 'package:active_ecommerce_seller_app/screens/login.dart';
import 'package:active_ecommerce_seller_app/screens/main.dart';
import 'package:active_ecommerce_seller_app/screens/orders.dart';
import 'package:active_ecommerce_seller_app/screens/pos/pos_config.dart';
import 'package:active_ecommerce_seller_app/screens/pos/pos_manager.dart';
import 'package:active_ecommerce_seller_app/screens/product/products.dart';
import 'package:active_ecommerce_seller_app/screens/profile.dart';
import 'package:active_ecommerce_seller_app/screens/uploads/upload_file.dart';
import 'package:active_ecommerce_seller_app/screens/whole_sale_product/products.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:toast/toast.dart';

import 'auction/auction_product.dart';
import 'digital_product/digital_product.dart';
import 'product_queries/product_queries.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> with TickerProviderStateMixin {
  late AnimationController controller;
  Animation? animation;

  bool? _verify = false;
  bool _faceData = false;
  bool _auctionExpand = false;
  bool _posExpand = false;

  String? _url = "",
      _name = "...",
      _email = "...",
      _rating = "...",
      _verified = "..",
      _package = "",
      _packageImg = "";

  Future<bool> _getAccountInfo() async {
    ShopInfoHelper().setShopInfo();
    setData();
    return true;
  }

  getSellerPackage() async {
    var _shopInfo = await ShopRepository().getShopInfo();
    _package = _shopInfo.shopInfo!.sellerPackage;
    _packageImg = _shopInfo.shopInfo!.sellerPackageImg;
    print(_packageImg);
    setState(() {});
  }

  setData() {
    //Map<String, dynamic> json = jsonDecode(shop_info.$.toString());
    _url = shop_logo.$;
    _name = shop_name.$;
    _email = seller_email.$;
    _verify = shop_verify.$;
    _verified = _verify!
        ? LangText(context: OneContext().context).getLocal().verified_ucf
        : LangText(context: OneContext().context).getLocal().unverified_ucf;
    _rating = shop_rating.$;
    _faceData = true;
    setState(() {});
  }

  final ExpansionTileController expansionTileController =
      ExpansionTileController();
  logoutReq() async {
    var response = await AuthRepository().getLogoutResponse();

    if (response.result!) {
      access_token.$ = "";
      access_token.save();
      is_logged_in.$ = false;
      is_logged_in.save();
      Navigator.pushAndRemoveUntil(
        context,
        PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) => Login(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              return FadeTransition(
                opacity: animation,
                child: child,
              );
            }),
        (route) => false,
      );
    } else {
      ToastComponent.showDialog(
        response.message!,
        gravity: Toast.center,
        duration: 3,
        textStyle: TextStyle(color: MyTheme.black),
      );
    }
  }

  faceData() {
    _getAccountInfo();
    getSellerPackage();
  }

  loadData() async {
    if (shop_name.$ == "") {
      _getAccountInfo();
    } else {
      setData();
    }
  }

  @override
  void initState() {
    if (seller_package_addon.$) {
      getSellerPackage();
    }
    loadData();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);
    animation = Tween(begin: 0.5, end: 1.0).animate(controller);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyTheme.app_accent_color,
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // This is the back button
              buildBackButtonContainer(context),

              Container(
                color: MyTheme.app_accent_color_extra_light,
                height: 1,
              ),

              const SizedBox(
                height: 20,
              ),

              //header
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    MyWidget.roundImageWithPlaceholder(
                        width: 48.0,
                        height: 48.0,
                        borderRadius: 24.0,
                        url: _url,
                        backgroundColor: MyTheme.noColor),
                    /*Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          image: DecorationImage(
                              image: NetworkImage(
                                  "https://demo.activeitzone.com/ecommerce_flutter_demo/public/uploads/all/999999999920220118113113.jpg"),
                              fit: BoxFit.cover)),
                    ),*/
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "" + _name.toString(),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: MyTheme.white),
                        ),
                        Text(
                          "" + _email.toString(),
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color:
                                  MyTheme.app_accent_border.withOpacity(0.8)),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/star.png',
                              width: 16,
                              height: 15,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              "" + _rating!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: MyTheme.app_accent_border),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            // MyWidget.roundImageWithPlaceholder(width: 16.0,height: 16.0,borderRadius:10.0,url: _verifiedImg ),
                            _faceData
                                ? Image.asset(
                                    _verify!
                                        ? 'assets/icon/verify.png'
                                        : 'assets/icon/unverify.png',
                                    width: 16,
                                    height: 15,
                                  )
                                : Container(),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              _verified!,
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: MyTheme.app_accent_border),
                            ),
                            seller_package_addon.$ && _package!.isNotEmpty
                                ? Row(
                                    children: [
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      MyWidget.roundImageWithPlaceholder(
                                          width: 16.0,
                                          height: 15.0,
                                          borderRadius: 0.0,
                                          url: _packageImg,
                                          backgroundColor: MyTheme.noColor,
                                          fit: BoxFit.fill),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        _package!,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            color: MyTheme.app_accent_border),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),

              const SizedBox(
                height: 20,
              ),
              Container(
                color: MyTheme.app_accent_color_extra_light,
                height: 1,
              ),
              // SizedBox(height: 20,),
              Container(
                color: MyTheme.app_accent_color,
                height: 1,
              ),
              const SizedBox(
                height: 20,
              ),
              buildItemFeature(context),
              const SizedBox(
                height: 20,
              ),
              Container(
                color: MyTheme.app_accent_color_extra_light,
                height: 1,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15),
                height: 80,
                alignment: Alignment.center,
                child: SizedBox(
                  height: 40,
                  child: Buttons(
                    onPressed: () {
                      logoutReq();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              'assets/icon/logout.png',
                              width: 16,
                              height: 16,
                              color: MyTheme.app_accent_border,
                            ),
                            const SizedBox(
                              width: 26,
                            ),
                            Text(
                              LangText(context: context).getLocal()!.logout_ucf,
                              style:
                                  TextStyle(fontSize: 14, color: MyTheme.white),
                            ),
                          ],
                        ),
                        const Icon(
                          Icons.navigate_next_rounded,
                          size: 20,
                          color: MyTheme.app_accent_border,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                color: MyTheme.app_accent_color_extra_light,
                height: 1,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container buildBackButtonContainer(BuildContext context) {
    return Container(
      height: 47,
      alignment: Alignment.topRight,
      child: SizedBox(
        width: 47,
        child: Buttons(
          padding: EdgeInsets.zero,
          onPressed: () {
            pop(context);
          },
          child: const Icon(
            Icons.close,
            size: 24,
            color: MyTheme.app_accent_border,
          ),
        ),
      ),
    );
  }

  Widget buildItemFeature(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Buttons(
              onPressed: () {
                MyTransaction(context: context).push(const ProfileEdit());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon/profile.png',
                        width: 16,
                        height: 16,
                        color: MyTheme.app_accent_border,
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Text(
                        LangText(context: context).getLocal()!.profile_ucf,
                        style: TextStyle(fontSize: 14, color: MyTheme.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    size: 20,
                    color: MyTheme.app_accent_border,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: Buttons(
              onPressed: () {
                MyTransaction(context: context).push(ChangeLanguage());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon/language.png',
                        width: 16,
                        height: 16,
                        color: MyTheme.app_accent_border,
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Text(
                        LangText(context: context)
                            .getLocal()!
                            .change_language_ucf,
                        style: TextStyle(fontSize: 14, color: MyTheme.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    size: 20,
                    color: MyTheme.app_accent_border,
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 40,
            child: Buttons(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          Main(),
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        return FadeTransition(
                          opacity: animation,
                          child: child,
                        );
                      }),
                  (route) => false,
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon/dashboard.png',
                        width: 16,
                        height: 16,
                        color: MyTheme.app_accent_border,
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Text(
                        LangText(context: context).getLocal()!.dashboard_ucf,
                        style: TextStyle(fontSize: 14, color: MyTheme.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    size: 20,
                    color: MyTheme.app_accent_border,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: Buttons(
              onPressed: () {
                MyTransaction(context: context).push(const Orders());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon/orders.png',
                        width: 16,
                        height: 16,
                        color: MyTheme.app_accent_border,
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Text(
                        LangText(context: context).getLocal()!.orders_ucf,
                        style: TextStyle(fontSize: 14, color: MyTheme.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    size: 20,
                    color: MyTheme.app_accent_border,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: Buttons(
              onPressed: () {
                MyTransaction(context: context).push(const Products());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icon/products.png',
                          width: 16,
                          height: 16,
                          color: MyTheme.app_accent_border),
                      const SizedBox(
                        width: 26,
                      ),
                      Text(
                        LangText(context: context).getLocal()!.products_ucf,
                        style: TextStyle(fontSize: 14, color: MyTheme.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    size: 20,
                    color: MyTheme.app_accent_border,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: Buttons(
              onPressed: () {
                MyTransaction(context: context).push(const DigitalProducts());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset(
                        'assets/icon/download.png',
                        width: 16,
                        height: 16,
                        color: MyTheme.app_accent_border,
                      ),
                      const SizedBox(
                        width: 26,
                      ),
                      Text(
                        LangText(context: context)
                            .getLocal()!
                            .digital_product_ucf,
                        style: TextStyle(fontSize: 14, color: MyTheme.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    size: 20,
                    color: MyTheme.app_accent_border,
                  )
                ],
              ),
            ),
          ),
          if (pos_manager_activation.$) buildPosSystem(),
          if (wholesale_addon_installed.$)
            optionModel(
              LangText(context: context).getLocal()!.wholesale_products_ucf,
              'assets/icon/wholesale.png',
              const WholeSaleProducts(),
            ),
          if (auction_addon_installed.$)
            Container(
              height: _auctionExpand ? 100 : 44,
              alignment: Alignment.topCenter,
              padding: const EdgeInsets.only(top: 10.0),
              child: InkWell(
                onTap: () {
                  _auctionExpand = !_auctionExpand;
                  setState(() {});
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset('assets/icon/auction.png',
                                width: 16,
                                height: 16,
                                color: MyTheme.app_accent_border),
                            //Image.asset('assets/icon/commission_history.png',width: 16,height: 16,color: MyTheme.app_accent_border),
                            const SizedBox(
                              width: 26,
                            ),
                            Text(
                              LangText(context: context)
                                  .getLocal()!
                                  .auction_ucf,
                              style: TextStyle(
                                fontSize: 14,
                                color: MyTheme.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Icon(
                          _auctionExpand
                              ? Icons.keyboard_arrow_down
                              : Icons.navigate_next_rounded,
                          size: 20,
                          color: MyTheme.app_accent_border,
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Visibility(
                      visible: _auctionExpand,
                      child: Container(
                        padding: const EdgeInsets.only(left: 40),
                        width: DeviceInfo(context).getWidth(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () => OneContext().push(
                                MaterialPageRoute(
                                  builder: (_) => const AuctionProduct(),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '-',
                                    style: TextStyle(
                                      color: MyTheme.white,
                                    ),
                                  ),
                                  Text(
                                    '  ${LangText(context: context).getLocal()!.auction_product_ucf}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: MyTheme.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () => OneContext().push(
                                MaterialPageRoute(
                                  builder: (_) => const AuctionOrder(),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Text(
                                    '-',
                                    style: TextStyle(
                                      color: MyTheme.white,
                                    ),
                                  ),
                                  Text(
                                    '  ${LangText(context: context).getLocal()!.auction_order_ucf}',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: MyTheme.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          SizedBox(
            height: 40,
            child: Buttons(
              onPressed: () {
                MyTransaction(context: context).push(const CommissionHistory());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Image.asset('assets/icon/commission_history.png',
                          width: 16,
                          height: 16,
                          color: MyTheme.app_accent_border),
                      const SizedBox(
                        width: 26,
                      ),
                      Text(
                        LangText(context: context)
                            .getLocal()!
                            .commission_history_ucf,
                        style: TextStyle(fontSize: 14, color: MyTheme.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    size: 20,
                    color: MyTheme.app_accent_border,
                  )
                ],
              ),
            ),
          ),
          SizedBox(
            height: 40,
            child: Buttons(
              onPressed: () {
                MyTransaction(context: context).push(const UploadFile());
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const Icon(
                        Icons.upload_file,
                        size: 16,
                        color: MyTheme.app_accent_border,
                      ),
                      //Image.asset('assets/icon/commission_history.png',width: 16,height: 16,color: MyTheme.app_accent_border),
                      const SizedBox(
                        width: 26,
                      ),
                      Text(
                        LangText(context: context).getLocal()!.upload_file_ucf,
                        style: TextStyle(fontSize: 14, color: MyTheme.white),
                      ),
                    ],
                  ),
                  const Icon(
                    Icons.navigate_next_rounded,
                    size: 20,
                    color: MyTheme.app_accent_border,
                  )
                ],
              ),
            ),
          ),
          if (product_query_activation.$)
            SizedBox(
              height: 40,
              child: Buttons(
                onPressed: () {
                  MyTransaction(context: context).push(const ProductQueries());
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.question_mark_rounded,
                          size: 16,
                          color: MyTheme.app_accent_border,
                        ),
                        //Image.asset('assets/icon/commission_history.png',width: 16,height: 16,color: MyTheme.app_accent_border),
                        const SizedBox(
                          width: 26,
                        ),
                        Text(
                          LangText(context: context)
                              .getLocal()!
                              .product_queries_ucf,
                          style: TextStyle(fontSize: 14, color: MyTheme.white),
                        ),
                      ],
                    ),
                    const Icon(
                      Icons.navigate_next_rounded,
                      size: 20,
                      color: MyTheme.app_accent_border,
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  SizedBox optionModel(String title, String logo, Widget route) {
    return SizedBox(
      height: 40,
      child: Buttons(
        onPressed: () {
          MyTransaction(context: context).push(route);
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.asset(logo,
                    width: 16, height: 16, color: MyTheme.app_accent_border),
                const SizedBox(
                  width: 26,
                ),
                Text(
                  title,
                  style: TextStyle(fontSize: 14, color: MyTheme.white),
                ),
              ],
            ),
            const Icon(
              Icons.navigate_next_rounded,
              size: 20,
              color: MyTheme.app_accent_border,
            )
          ],
        ),
      ),
    );
  }

  buildPosSystem() {
    return Container(
      height: _posExpand ? 100 : 44,
      alignment: Alignment.topCenter,
      padding: const EdgeInsets.only(top: 10.0),
      child: InkWell(
        onTap: () {
          _posExpand = !_posExpand;
          setState(() {});
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset('assets/icon/pos_system.png',
                        width: 16,
                        height: 16,
                        color: MyTheme.app_accent_border),
                    //Image.asset('assets/icon/commission_history.png',width: 16,height: 16,color: MyTheme.app_accent_border),
                    const SizedBox(
                      width: 26,
                    ),
                    Text(
                      "POS System",
                      style: TextStyle(
                        fontSize: 14,
                        color: MyTheme.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Icon(
                  _posExpand
                      ? Icons.keyboard_arrow_down
                      : Icons.navigate_next_rounded,
                  size: 20,
                  color: MyTheme.app_accent_border,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Visibility(
              visible: _posExpand,
              child: Container(
                padding: const EdgeInsets.only(left: 40),
                width: DeviceInfo(context).getWidth(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () => MyTransaction(context: context)
                          .push(const PosManager()),
                      child: Row(
                        children: [
                          Text(
                            '-',
                            style: TextStyle(
                              color: MyTheme.white,
                            ),
                          ),
                          Text(
                            '  Pos Manager',
                            style: TextStyle(
                              fontSize: 14,
                              color: MyTheme.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () => MyTransaction(context: context)
                          .push(const PosConfig()),
                      child: Row(
                        children: [
                          Text(
                            '-',
                            style: TextStyle(
                              color: MyTheme.white,
                            ),
                          ),
                          Text(
                            '  Pos Configuration',
                            style: TextStyle(
                              fontSize: 14,
                              color: MyTheme.white,
                            ),
                          ),
                        ],
                      ),
                    ),
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
