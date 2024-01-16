import 'package:active_ecommerce_seller_app/const/app_style.dart';
import 'package:active_ecommerce_seller_app/custom/device_info.dart';
import 'package:active_ecommerce_seller_app/custom/localization.dart';
import 'package:active_ecommerce_seller_app/custom/my_app_bar.dart';
import 'package:active_ecommerce_seller_app/custom/my_widget.dart';
import 'package:active_ecommerce_seller_app/helpers/shimmer_helper.dart';
import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:one_context/one_context.dart';
import 'package:toast/toast.dart';

import '../../custom/buttons.dart';
import '../../custom/toast_component.dart';
import '../../data_model/auction_product_bids_response.dart';
import '../../repositories/product_repository.dart';

class ViewAllBids extends StatefulWidget {
  final productId;

  const ViewAllBids({
    Key? key,
    this.productId,
  }) : super(key: key);

  @override
  State<ViewAllBids> createState() => _ViewAllBidsState();
}

class _ViewAllBidsState extends State<ViewAllBids> {
  var _productBidsCustomerList = <AuctionBidCustomerList>[];
  int _page = 0;
  bool _showLoadingContainer = false;
  bool _faceData = false;
  late BuildContext loadingContext;

  ScrollController _scrollController = ScrollController();

  getCustomerList() async {
    var response = await ProductRepository()
        .auctionProductBids(page: _page, id: widget.productId);

    if (response.success!) {
      _productBidsCustomerList.addAll(response.data!);
    }
    _showLoadingContainer = false;

    _faceData = true;
    print("data face " + _faceData.toString());
    setState(() {});
  }

  scrollControllerListener() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _page++;
        });
        _showLoadingContainer = true;
        fetchData();
      }
    });
  }

  fetchData() {
    getCustomerList();
  }

  clearData() {
    _faceData = false;
    _productBidsCustomerList = [];
    _page = 0;
    _showLoadingContainer = false;
    setState(() {});
  }

  Future<void> refresh() async {
    clearData();
    fetchData();
  }

  @override
  void initState() {
    // TODO: implement initState
    scrollControllerListener();
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        context: context,
        title: LangText(context: context).getLocal()!.auction_all_bids_ucf,
      ).show(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: CustomScrollView(
          controller: _scrollController,
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      child: !_faceData
                          ? ShimmerHelper().buildListShimmer(
                              item_count: 10, item_height: 100.0)
                          : _productBidsCustomerList.isNotEmpty
                              ? ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount:
                                      _productBidsCustomerList.length + 1,
                                  itemBuilder: (context, index) {
                                    if (index ==
                                        _productBidsCustomerList.length) {
                                      return moreLoading();
                                    }
                                    return customerList(context, index);
                                  })
                              : SizedBox(
                                  height: DeviceInfo(context).getHeight() / 1.5,
                                  child: Center(
                                      child: Text(LangText(context: context)
                                          .getLocal()!
                                          .no_data_is_available)),
                                ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  customerList(BuildContext context, int index) {
    return MyWidget.customCardView(
      backgroundColor: MyTheme.app_accent_color_extra_light,
      elevation: 5,
      height: 105,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      width: DeviceInfo(context).getWidth(),
      margin: EdgeInsets.only(top: AppStyles.listItemsMargin),
      borderColor: MyTheme.app_accent_border,
      borderWidth: 1,
      alignment: Alignment.center,
      borderRadius: 6,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: DeviceInfo(context).getWidth() / 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _productBidsCustomerList[index].customerName!,
                  style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: MyTheme.app_accent_color),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _productBidsCustomerList[index].customerEmail!,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: MyTheme.font_grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _productBidsCustomerList[index].customerPhone!,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: MyTheme.font_grey),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  _productBidsCustomerList[index].date!,
                  style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                      color: MyTheme.font_grey),
                ),
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onTap: () => showDeleteWarningDialog(
                    context, _productBidsCustomerList[index].id),
                child: SizedBox(
                  height: 16,
                  width: 16,
                  child: Image.asset(
                    "assets/icon/delete.png",
                    height: 12,
                    width: 8,
                    color: MyTheme.app_accent_color,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Text(
                _productBidsCustomerList[index].biddedAmout.toString(),
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: MyTheme.app_accent_color),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> showDeleteWarningDialog(BuildContext context, id) {
    return showDialog(
        context: context,
        builder: (context) => SizedBox(
              width: DeviceInfo(context).getWidth() * 1.5,
              child: AlertDialog(
                title: Text(
                  LangText(context: context).getLocal()!.warning_ucf,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: MyTheme.red),
                ),
                content: Text(
                  LangText(context: context)
                      .getLocal()!
                      .do_you_want_to_delete_it,
                  style: const TextStyle(
                      fontWeight: FontWeight.w400, fontSize: 14),
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
                        deleteAuctionProduct(id);
                      },
                      child: Text(
                          LangText(context: context).getLocal()!.yes_ucf,
                          style:
                              TextStyle(color: MyTheme.white, fontSize: 12))),
                ],
              ),
            ));
  }

  deleteAuctionProduct(int? id) async {
    loading();
    var response = await ProductRepository().auctionProductDeleteReq(id: id);
    // Navigator.pop(loadingContext);
    OneContext().popDialog(loadingContext);
    if (response.result) {
      refresh();
    }
    ToastComponent.showDialog(
      response.message,
      gravity: Toast.center,
      duration: 3,
      textStyle: const TextStyle(color: MyTheme.black),
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

  bool textIsOverFlow(mytext, maxWidth) {
    // Build the textspan
    var span = TextSpan(
      text: mytext,
      style: const TextStyle(fontSize: 12),
    );

    // Use a textpainter to determine if it will exceed max lines
    var tp = TextPainter(
      maxLines: 2,
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      text: span,
    );

    // trigger it to layout
    tp.layout(maxWidth: maxWidth);

    // whether the text overflowed or not
    var exceeded = tp.didExceedMaxLines;
    return exceeded;
  }

  double textLineHeight(mytext, maxWidth) {
    // Build the textspan
    var span = TextSpan(
      text: mytext,
      style: const TextStyle(fontSize: 12),
    );

    // Use a textpainter to determine if it will exceed max lines
    var tp = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      text: span,
    );

    // trigger it to layout
    tp.layout(maxWidth: maxWidth);

    // whether the text overflowed or not
    var exceeded = tp.height;
    return exceeded;
  }

  int textLines(mytext, maxWidth) {
    // Build the textspan
    var span = TextSpan(
      text: mytext,
      style: const TextStyle(fontSize: 12),
    );

    // Use a textpainter to determine if it will exceed max lines
    var tp = TextPainter(
      textAlign: TextAlign.left,
      textDirection: TextDirection.ltr,
      text: span,
    );

    // trigger it to layout
    tp.layout(maxWidth: maxWidth);

    // whether the text overflowed or not
    var exceeded = tp.computeLineMetrics().length;
    return exceeded;
  }

  Widget moreLoading() {
    return _showLoadingContainer
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
