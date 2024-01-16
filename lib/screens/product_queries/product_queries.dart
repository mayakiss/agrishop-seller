import 'package:active_ecommerce_seller_app/repositories/product_query_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:route_transitions/route_transitions.dart';
import 'package:toast/toast.dart';
import '../../custom/device_info.dart';
import '../../custom/loading.dart';
import '../../custom/localization.dart';
import '../../custom/my_app_bar.dart';
import '../../custom/my_widget.dart';
import '../../custom/toast_component.dart';
import '../../data_model/product_queries_response.dart';
import '../../helpers/shimmer_helper.dart';
import '../../my_theme.dart';
import 'product_queries_reply.dart';

class ProductQueries extends StatefulWidget {
  const ProductQueries({Key? key}) : super(key: key);

  @override
  State<ProductQueries> createState() => _ProductQueriesState();
}

class _ProductQueriesState extends State<ProductQueries> {
  var _productQueries = <ProductQueriesListModel>[];
  bool _isFetchAllData = false;
  bool _showMoreProductQueriesLoading = false;
  ScrollController _scrollController = ScrollController(initialScrollOffset: 0);
  late int _page = 1;

  //refresh
  Future<Future<bool>> refresh() async {
    await resetData();
    return fetchData();
  }

  // reset
  resetData() {
    _scrollController = ScrollController(initialScrollOffset: 0);
    _page = 1;
    _isFetchAllData = false;
    _productQueries = [];
    setState(() {});
  }

// get product queries list method
  Future<bool> getProductQueriesList() async {
    var response =
        await ProductQueryRepository().getProductQueriesList(page: _page);

    if (response.data!.isEmpty) {
      ToastComponent.showDialog(
          LangText(context: context).getLocal()!.no_more_queries_ucf,
          gravity: Toast.center,
          bgColor: MyTheme.white,
          textStyle: TextStyle(color: Colors.black));
    }
    _productQueries.addAll(response.data!);
    _showMoreProductQueriesLoading = false;
    setState(() {});
    return true;
  }

  // fetch method
  Future<bool> fetchData() async {
    await getProductQueriesList();
    _isFetchAllData = true;
    setState(() {});
    return true;
  }

  //init method
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollControllerPosition();
    fetchData();
  }

  // scroll controller
  scrollControllerPosition() {
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _showMoreProductQueriesLoading = true;
        setState(() {
          _page++;
        });
        getProductQueriesList();
      }
    });
  }

  // _showPopUpMenu() {
  //   print('show menu');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
              title: AppLocalizations.of(context)!.product_queries_ucf,
              context: context)
          .show(),
      body: RefreshIndicator(
        onRefresh: refresh,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Container(
                child: _isFetchAllData
                    ? productQueriesListContainer()
                    : ShimmerHelper()
                        .buildListShimmer(item_count: 20, item_height: 80.0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget productQueriesListContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _productQueries.isNotEmpty
              ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: _productQueries.length + 1,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index == _productQueries.length) {
                      return Loading.bottomLoading(
                          _showMoreProductQueriesLoading);
                    }
                    return productQueriesItem(
                      index,
                      _productQueries[index].userName!,
                      _productQueries[index].product!,
                      _productQueries[index].status!,
                      _productQueries[index].id,
                      _productQueries[index].question,
                    );
                  },
                )
              : Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Center(
                      child: Text(LangText(context: context)
                          .getLocal()
                          .no_queries_found_ucf)),
                ),
        ],
      ),
    );
  }

  Widget productQueriesItem(int index, String name, String productName,
      String status, productId, question) {
    return InkWell(
      onTap: () {
        slideRightWidget(
                newPage: ProductQueryReply(
                  id: productId,
                ),
                context: context)
            .then((value) {
          refresh();
        });
      },
      child: MyWidget.customCardView(
        backgroundColor: MyTheme.app_accent_color_extra_light,
        elevation: 5,
        height: 110,
        alignment: Alignment.center,
        padding: const EdgeInsets.only(right: 0, top: 14, bottom: 14, left: 14),
        width: DeviceInfo(context).getWidth(),
        margin: EdgeInsets.only(bottom: 20, top: index == 0 ? 20 : 0),
        borderColor: MyTheme.light_grey,
        borderRadius: 6,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  "assets/icon/profile.png",
                  width: 12,
                  height: 12,
                  color: MyTheme.dark_grey,
                ),
                const SizedBox(
                  width: 8,
                ),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    //color: MyTheme.app_accent_color,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: DeviceInfo(context).getWidth(),
              child: Row(
                children: [
                  Image.asset(
                    "assets/icon/products.png",
                    width: 12,
                    height: 12,
                    color: MyTheme.dark_grey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: DeviceInfo(context).getWidth() - 65,
                    child: Text(
                      productName,
                      style: const TextStyle(
                        fontSize: 12,
                        color: MyTheme.app_accent_color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: DeviceInfo(context).getWidth(),
              child: Row(
                children: [
                  Image.asset("assets/icon/help_center.png",
                      width: 12, height: 12, color: MyTheme.dark_grey),
                  const SizedBox(
                    width: 8,
                  ),
                  SizedBox(
                    width: DeviceInfo(context).getWidth() - 65,
                    child: Text(
                      question,
                      style: const TextStyle(
                        fontSize: 12,
                        color: MyTheme.app_accent_color,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            SizedBox(
              width: DeviceInfo(context).getWidth() / 3,
              child: Row(
                children: [
                  Image.asset(
                    "assets/icon/replay.png",
                    width: 12,
                    height: 12,
                    color: MyTheme.dark_grey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Text(
                    status,
                    style: TextStyle(
                      fontSize: 12,
                      color: status == "Replied"
                          ? MyTheme.dark_grey
                          : Colors.red[300],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
