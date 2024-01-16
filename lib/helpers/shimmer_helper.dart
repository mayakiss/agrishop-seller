import 'package:active_ecommerce_seller_app/my_theme.dart';
import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:shimmer/shimmer.dart';


import '../custom/device_info.dart';


class ShimmerHelper {
  buildPosShimmer(
      {double height = double.infinity, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: MyTheme.shimmer_base,
      highlightColor: MyTheme.shimmer_highlighted,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Container(
              height: 36,
              width: width,
              color: Colors.white,
            ),
            const SizedBox(
              height: 10,
            ),
            Container(
              height: 245,
              width: double.infinity,
              color: Colors.white,
            ),
            const Spacer(),
            Container(
              height: 245,
              width: double.infinity,
              color: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  buildBasicShimmer(
      {double height = double.infinity, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: MyTheme.shimmer_base,
      highlightColor: MyTheme.shimmer_highlighted,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }

  buildBoxShimmer(
      {double height = double.infinity, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: MyTheme.app_accent_color_extra_light,
      highlightColor: MyTheme.shimmer_highlighted,
      child: Container(
        height: height,
        width: width,
        color: Colors.white,
      ),
    );
  }


  buildProductReplyShimmer(
      {double height = double.infinity, double width = double.infinity}) {
    return Shimmer.fromColors(
      baseColor: MyTheme.app_accent_color_extra_light,
      highlightColor: MyTheme.shimmer_highlighted,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              height: 30,
              // width: double.infinity,
              width: DeviceInfo(OneContext().context).getWidth() / .65,
            ),
            itemSpacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 23,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.white,
                      height: 18,
                      width: 200,
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Container(
                      color: Colors.white,
                      height: 8,
                      width: 120,
                    ),
                  ],
                )
              ],
            ),
            itemSpacer(),
            Container(
              color: Colors.white,
              height: 150,
              width: double.infinity,
            ),
            itemSpacer(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 30,
                  width: 65,
                  color: Colors.white,
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget itemSpacer({double height = 24}) {
    return SizedBox(
      height: height,
    );
  }


  buildListShimmer({item_count = 10, item_height = 100.0}) {
    return ListView.builder(
      itemCount: item_count,
      scrollDirection: Axis.vertical,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(
              top: 0.0, left: 16.0, right: 16.0, bottom: 16.0),
          child: ShimmerHelper().buildBasicShimmer(height: item_height),
        );
      },
    );
  }

  buildProductGridShimmer({scontroller, item_count = 10}) {
    return GridView.builder(
      itemCount: item_count,
      controller: scontroller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 0.7),
      padding: EdgeInsets.all(8),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: MyTheme.shimmer_base,
            highlightColor: MyTheme.shimmer_highlighted,
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }

  buildSquareGridShimmer({scontroller, item_count = 10}) {
    return GridView.builder(
      itemCount: item_count,
      controller: scontroller,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          childAspectRatio: 1),
      padding: EdgeInsets.all(8),
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: MyTheme.shimmer_base,
            highlightColor: MyTheme.shimmer_highlighted,
            child: Container(
              height: 120,
              width: double.infinity,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
