import 'package:active_ecommerce_seller_app/const/app_style.dart';
import 'package:active_ecommerce_seller_app/custom/buttons.dart';
import 'package:active_ecommerce_seller_app/custom/common_style.dart';
import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:active_ecommerce_seller_app/custom/my_app_bar.dart';
import 'package:active_ecommerce_seller_app/custom/my_widget.dart';
import 'package:active_ecommerce_seller_app/custom/route_transaction.dart';
import 'package:active_ecommerce_seller_app/custom/submitButton.dart';
import 'package:active_ecommerce_seller_app/custom/toast_component.dart';
import 'package:active_ecommerce_seller_app/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_seller_app/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:active_ecommerce_seller_app/repositories/product_repository.dart';
import 'package:active_ecommerce_seller_app/repositories/shop_repository.dart';
import 'package:active_ecommerce_seller_app/screens/auction/view_all_bids.dart';
import 'package:active_ecommerce_seller_app/screens/packages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:toast/toast.dart';

import '../../data_model/auction_product_list_response.dart';
import 'auction_update_product.dart';
import 'new_auction_product.dart';

class AuctionProduct extends StatefulWidget {
  final bool fromBottomBar;

  const AuctionProduct({Key? key, this.fromBottomBar = false})
      : super(key: key);

  @override
  AuctionProductState createState() => AuctionProductState();
}

class AuctionProductState extends State<AuctionProduct> {
  bool _isProductInit = false;
  bool _showMoreProductLoadingContainer = false;

  List<AuctionProductModel> _productList = [];

  String _remainingProduct = "...";
  String? _currentPackageName = "...";
  late BuildContext loadingContext;
  late BuildContext switchContext;
  late BuildContext featuredSwitchContext;

  ScrollController _scrollController =
      new ScrollController(initialScrollOffset: 0);

  // double variables
  double mHeight = 0.0, mWidht = 0.0;
  int _page = 1;

  getProductList() async {
    var productResponse =
        await ProductRepository().getAuctionProducts(page: _page);
    if (productResponse.data!.isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal()!.no_more_products_ucf,
          gravity: Toast.center,
          bgColor: MyTheme.white,
          textStyle: TextStyle(color: Colors.black));
    }
    _productList.addAll(productResponse.data!);
    _showMoreProductLoadingContainer = false;
    _isProductInit = true;
    setState(() {});
  }

  Future<bool> _getAccountInfo() async {
    var response = await ShopRepository().getShopInfo();
    _currentPackageName = response.shopInfo!.sellerPackage;
    setState(() {});
    return true;
  }

  getProductRemainingUpload() async {
    var productResponse = await ProductRepository().remainingUploadProducts();
    _remainingProduct = productResponse.ramainingProduct.toString();

    setState(() {});
  }

  deleteProduct(int? id) async {
    loading();
    var response = await ProductRepository().productDeleteReq(id: id);
    Navigator.pop(loadingContext);
    if (response.result) {
      resetAll();
    }
    ToastComponent.showDialog(
      response.message,
      gravity: Toast.center,
      duration: 3,
      textStyle: TextStyle(color: MyTheme.black),
    );
  }

  scrollControllerPosition() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _showMoreProductLoadingContainer = true;
        setState(() {
          _page++;
        });
        getProductList();
      }
    });
  }

  cleanAll() {
    _isProductInit = false;
    _showMoreProductLoadingContainer = false;
    _productList = [];
    _page = 1;
    _currentPackageName = "...";
    _remainingProduct = "....";
    setState(() {});
  }

  fetchAll() {
    getProductList();
    _getAccountInfo();
    getProductRemainingUpload();
    setState(() {});
  }

  resetAll() {
    cleanAll();
    fetchAll();
  }

  _tabOption(int index, productId, listIndex) {
    switch (index) {
      case 0:
        slideRightWidget(
                newPage: AuctionUpdateProduct(
                  productId: productId,
                ),
                context: context)
            .then(
          (value) {
            resetAll();
          },
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ViewAllBids(
              productId: productId,
            ),
          ),
        );
        break;
      case 2:
        showDeleteWarningDialog(productId);
        // deleteProduct(productId);
        break;
      default:
        break;
    }
  }

  @override
  void initState() {
    scrollControllerPosition();
    fetchAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    mHeight = MediaQuery.of(context).size.height;
    mWidht = MediaQuery.of(context).size.width;
    return Directionality(
      textDirection:
          app_language_rtl.$! ? TextDirection.rtl : TextDirection.ltr,
      child: Scaffold(
        appBar: !widget.fromBottomBar
            ? MyAppBar(
                    context: context,
                    title: LangText(context: context)
                        .getLocal()!
                        .auction_product_screen_title)
                .show()
            : null,
        body: RefreshIndicator(
          triggerMode: RefreshIndicatorTriggerMode.anywhere,
          onRefresh: () async {
            resetAll();
            // Future.delayed(Duration(seconds: 1));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _scrollController,
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                buildTop2BoxContainer(context),
                Visibility(
                    visible: seller_package_addon.$,
                    child: buildPackageUpgradeContainer(context)),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  child: _isProductInit
                      ? productsContainer()
                      : ShimmerHelper()
                          .buildListShimmer(item_count: 20, item_height: 80.0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPackageUpgradeContainer(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: AppStyles.itemMargin,
        ),
        MyWidget().myContainer(
          marginY: 15,
          height: 40,
          width: DeviceInfo(context).getWidth(),
          borderRadius: 6,
          borderColor: MyTheme.app_accent_color,
          bgColor: MyTheme.app_accent_color_extra_light,
          child: InkWell(
            onTap: () {
              MyTransaction(context: context).push(const Packages());
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Image.asset("assets/icon/package.png",
                        height: 20, width: 20),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      LangText(context: context)
                          .getLocal()!
                          .current_package_ucf,
                      style: TextStyle(fontSize: 10, color: MyTheme.grey_153),
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      _currentPackageName!,
                      style: const TextStyle(
                          fontSize: 10,
                          color: MyTheme.app_accent_color,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(
                  width: 5,
                ),
                Row(
                  children: [
                    Text(
                      LangText(context: context)
                          .getLocal()!
                          .upgrade_package_ucf,
                      style: const TextStyle(
                          fontSize: 12,
                          color: MyTheme.app_accent_color,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    Image.asset("assets/icon/next_arrow.png",
                        color: MyTheme.app_accent_color, height: 8.7, width: 7),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Container buildTop2BoxContainer(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              //border: Border.all(color: MyTheme.app_accent_border),
              color: MyTheme.app_accent_color,
            ),
            height: 75,
            width: mWidht / 2 - 23,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  LangText(context: context).getLocal()!.remaining_uploads,
                  style: MyTextStyle().dashboardBoxText(context),
                ),
                Text(
                  _remainingProduct,
                  style: MyTextStyle().dashboardBoxNumber(context),
                ),
              ],
            ),
          ),
          SizedBox(
            width: AppStyles.itemMargin,
          ),
          Container(
            child: SubmitBtn.show(
              onTap: () {
                MyTransaction(context: context)
                    .push(
                  const NewAuctionProduct(),
                )
                    .then((value) {
                  resetAll();
                });
              },
              borderColor: MyTheme.app_accent_color,
              backgroundColor: MyTheme.app_accent_color_extra_light,
              height: 75,
              width: mWidht / 2 - 23,
              radius: 10,
              child: Container(
                padding: const EdgeInsets.all(10),
                height: 75,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      LangText(context: context)
                          .getLocal()!
                          .add_new_product_ucf,
                      style: MyTextStyle()
                          .dashboardBoxText(context)
                          .copyWith(color: MyTheme.app_accent_color),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/icon/add.png',
                          color: MyTheme.app_accent_color,
                          height: 24,
                          width: 42,
                          fit: BoxFit.contain,
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget productsContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LangText(context: context).getLocal()!.all_products_ucf,
            style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: MyTheme.app_accent_color),
          ),
          const SizedBox(
            height: 10,
          ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _productList.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              if (index == _productList.length) {
                return moreProductLoading();
              }
              return auctionProductItem(
                index: index,
                productId: _productList[index].id,
                imageUrl: _productList[index].thumbnailImage,
                productTitle: _productList[index].name!,
                startDate: _productList[index].startDate,
                endDate: _productList[index].endDate,
                productPrice: _productList[index].mainPrice.toString(),
                totalBids: _productList[index].totalBids!,
                canEdit: _productList[index].canEdit,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget auctionProductItem({
    int? index,
    productId,
    String? imageUrl,
    required String productTitle,
    required startDate,
    required endDate,
    required String productPrice,
    required int totalBids,
    required bool? canEdit,
  }) {
    return MyWidget.customCardView(
      elevation: 5,
      backgroundColor: MyTheme.white,
      height: 120,
      width: mWidht,
      margin: const EdgeInsets.only(
        bottom: 20,
      ),
      borderColor: MyTheme.light_grey,
      borderRadius: 6,
      child: Row(
        children: [
          MyWidget.imageWithPlaceholder(
            width: 84.0,
            height: 120.0,
            fit: BoxFit.cover,
            url: imageUrl,
            radius: const BorderRadius.only(
              topLeft: Radius.circular(5),
              bottomLeft: Radius.circular(5),
            ),
          ),
          const SizedBox(
            width: 11,
          ),
          Container(
            padding:
                const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
            width: mWidht - 129,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: mWidht - 160,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            productTitle,
                            style: const TextStyle(
                                fontSize: 14,
                                color: MyTheme.font_grey,
                                fontWeight: FontWeight.w400),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    showOptions(
                      listIndex: index,
                      productId: productId,
                      canEdit: canEdit,
                    ),
                  ],
                ),

                /// auction start date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LangText(context: context)
                          .getLocal()!
                          .auction_start_date_ucf,
                      style: const TextStyle(
                          fontSize: 12,
                          color: MyTheme.font_grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                        "${startDate.year}-${startDate.month}-${startDate.day} ${startDate.hour}:${startDate.minute}",
                        style: const TextStyle(
                            fontSize: 12, color: MyTheme.grey_153)),
                  ],
                ),

                /// auction end date
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      LangText(context: context)
                          .getLocal()!
                          .auction_end_date_ucf,
                      style: const TextStyle(
                          fontSize: 12,
                          color: MyTheme.font_grey,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                        "${endDate.year}-${endDate.month}-${endDate.day} ${endDate.hour}:${endDate.minute}",
                        style: const TextStyle(
                            fontSize: 12, color: MyTheme.grey_153)),
                  ],
                ),

                /// auction total bids
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        LangText(context: context)
                            .getLocal()!
                            .auction_total_bids_ucf,
                        style: const TextStyle(
                            fontSize: 12,
                            color: MyTheme.font_grey,
                            fontWeight: FontWeight.w400)),
                    Text(totalBids.toString(),
                        style: const TextStyle(
                            fontSize: 12, color: MyTheme.grey_153)),
                  ],
                ),

                /// auction product price
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                        LangText(context: context)
                            .getLocal()!
                            .auction_price_ucf,
                        style: const TextStyle(
                            fontSize: 12,
                            color: MyTheme.app_accent_color,
                            fontWeight: FontWeight.w400)),
                    Text(productPrice,
                        style: const TextStyle(
                            fontSize: 12, color: MyTheme.app_accent_color)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  showDeleteWarningDialog(id) {
    showDialog(
      context: context,
      builder: (context) => SizedBox(
        width: DeviceInfo(context).getWidth() * 1.5,
        child: AlertDialog(
          title: Text(
            LangText(context: context).getLocal()!.warning_ucf,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: MyTheme.red),
          ),
          content: Text(
            LangText(context: context).getLocal()!.do_you_want_to_delete_it,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
          ),
          actions: [
            Buttons(
                color: MyTheme.app_accent_color,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  LangText(context: context).getLocal()!.no_ucf,
                  style: TextStyle(color: MyTheme.white, fontSize: 12),
                )),
            Buttons(
                color: MyTheme.app_accent_color,
                onPressed: () {
                  Navigator.pop(context);
                  deleteProduct(id);
                },
                child: Text(LangText(context: context).getLocal()!.yes_ucf,
                    style: TextStyle(color: MyTheme.white, fontSize: 12))),
          ],
        ),
      ),
    );
  }

  Widget showOptions({listIndex, productId, canEdit}) {
    return SizedBox(
      child: PopupMenuButton<MenuOptions>(
        // offset: const Offset(-12, 0),
        child: Container(
          // color: Colors.red,
          width: 15,
          alignment: Alignment.topRight,
          child: Image.asset("assets/icon/more.png",
              height: 15, fit: BoxFit.contain, color: MyTheme.grey_153),
        ),
        onSelected: (MenuOptions result) {
          _tabOption(result.index, productId, listIndex);
          // setState(() {
          //   //_menuOptionSelected = result;
          // });
        },
        itemBuilder: (BuildContext context) => <PopupMenuEntry<MenuOptions>>[
          if (canEdit)
            PopupMenuItem<MenuOptions>(
              value: MenuOptions.Edit,
              child: Text(LangText(context: context).getLocal()!.edit_ucf),
            ),
          PopupMenuItem<MenuOptions>(
            value: MenuOptions.ViewAllBids,
            child: Text(
                LangText(context: context).getLocal()!.auction_view_bids_ucf),
          ),
          PopupMenuItem<MenuOptions>(
            value: MenuOptions.Delete,
            child: Text(LangText(context: context).getLocal()!.delete_ucf),
          ),
        ],
      ),
    );
  }

  loading() {
    showDialog(
      context: context,
      builder: (context) {
        loadingContext = context;
        return AlertDialog(
          content: Row(
            children: [
              const CircularProgressIndicator(),
              const SizedBox(
                width: 10,
              ),
              Text(AppLocalizations.of(context)!.please_wait_ucf),
            ],
          ),
        );
      },
    );
  }

  Widget moreProductLoading() {
    return _showMoreProductLoadingContainer
        ? Container(
            alignment: Alignment.center,
            child: const SizedBox(
              height: 40,
              width: 40,
              child: Row(
                children: [
                  SizedBox(
                    width: 2,
                    height: 2,
                  ),
                  CircularProgressIndicator(),
                ],
              ),
            ),
          )
        : const SizedBox(
            height: 5,
            width: 5,
          );
  }
}

enum MenuOptions { Edit, ViewAllBids, Delete }
