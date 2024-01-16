import 'package:active_ecommerce_seller_app/data_model/product/category_view_model.dart';
import 'package:active_ecommerce_seller_app/helpers/shimmer_helper.dart';
import 'package:flutter/material.dart';

import '../helpers/aiz_typedef.dart';

class MultiCategory extends StatefulWidget {
  MultiCategory(
      {super.key,
      required this.categories,
      required this.isCategoryInit,
      this.initialCategoryIds = const [],
      this.initialMainCategory,
      this.onSelectedCategories,
      this.onSelectedMainCategory});

  List<CategoryModel> categories;
  bool isCategoryInit;
  String? initialMainCategory;
  List? initialCategoryIds;
  GetString? onSelectedMainCategory;
  GetStringArray? onSelectedCategories;

  @override
  State<MultiCategory> createState() => _MultiCategoryState();
}

class _MultiCategoryState extends State<MultiCategory> {
  String? _selectedMainCategory;
  List<String> _selectedCategoryIds = [];

  @override
  void initState() {
    // TODO: implement initState
    if (widget.initialMainCategory != null) {
      _selectedMainCategory = widget.initialMainCategory;
      widget.onSelectedMainCategory!(_selectedMainCategory!);
    }

    if (widget.initialCategoryIds != null &&
        widget.initialCategoryIds!.isNotEmpty) {
      _selectedCategoryIds
          .addAll(widget.initialCategoryIds!.map((e) => e.toString()));

      widget.onSelectedCategories!(_selectedCategoryIds);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isCategoryInit
        ? _buildCategoryListView(widget.categories)
        : Container(
            //   color: Colors.red,
            height: 250,
            child: ShimmerHelper().buildListShimmer(item_height: 16.0)
            /*const Center(child:
            CircularProgressIndicator()
            )*/
            );
  }

  _buildCategoryListView(List<CategoryModel> categories,
      {double? padding, var height}) {
    return Container(
      height: height,
      padding: EdgeInsets.only(left: padding ?? 0.0),
      child: ListView.separated(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return SizedBox(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.only(top: 10, right: 10),
                    // color: Colors.yellow,
                    child: Row(
                      children: [
                        Container(
                          margin: EdgeInsets.only(right: 5),
                          height: 20,
                          width: 20,
                          child: categories[index].children.isNotEmpty
                              ? InkWell(
                                  onTap: () {
                                    if (categories[index].height == null)
                                      categories[index].height = 0.0;
                                    else
                                      categories[index].height = null;
                                    setChange();
                                  },
                                  child: Icon(
                                    categories[index].height != null
                                        ? Icons.add
                                        : Icons.remove,
                                    size: 18,
                                  ),
                                )
                              : SizedBox.shrink(),
                        ),
                        Container(
                          height: 18,
                          width: 18,
                          child: Transform.scale(
                            scale: 0.7,
                            child: Checkbox(
                                value: _selectedCategoryIds
                                    .contains(categories[index].id),
                                onChanged: (newValue) {
                                  if (newValue ?? false) {
                                    _selectedCategoryIds
                                        .add(categories[index].id!);
                                  } else {
                                    _selectedCategoryIds
                                        .remove(categories[index].id);
                                  }

                                  if (categories[index].children.isNotEmpty) {
                                    onSelectedCategory(
                                        categories[index].children,
                                        newValue ?? false);
                                  }
                                  setChange();
                                }),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          categories[index].title ?? "",
                          style: TextStyle(fontSize: 14),
                        ),
                        Spacer(),
                        Container(
                          // color: Colors.red,
                          height: 20,
                          width: 20,
                          child: InkWell(
                            onTap: () {
                              _selectedMainCategory = categories[index].id;
                              setChange();
                            },
                            child: Transform.scale(
                              scale: 0.7,
                              child: Radio(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: categories[index].id,
                                  groupValue: _selectedMainCategory,
                                  onChanged: (newValue) {
                                    _selectedMainCategory = newValue;
                                    setChange();
                                  }),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  if (categories[index].children!.isNotEmpty)
                    _buildCategoryListView(categories[index].children!,
                        padding: 14.0, height: categories[index].height)
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => SizedBox(
                height: 0,
              ),
          itemCount: categories.length),
    );
  }

  onSelectedCategory(List<CategoryModel> categories, bool action) {
    for (int index = 0; index < categories.length; index++) {
      if (action) {
        _selectedCategoryIds.add(categories[index].id!);
        if (categories[index].children.isNotEmpty) {
          onSelectedCategory(categories[index].children, action);
        }
      } else {
        _selectedCategoryIds.remove(categories[index].id);
        if (categories[index].children.isNotEmpty) {
          onSelectedCategory(categories[index].children, action);
        }
      }
    }
  }

  setChange() {
    if (_selectedMainCategory != null) {
      widget.onSelectedMainCategory!(_selectedMainCategory!);
    }
    if (_selectedCategoryIds.isNotEmpty) {
      widget.onSelectedCategories!(_selectedCategoryIds);
    }
    setState(() {});
  }
}
