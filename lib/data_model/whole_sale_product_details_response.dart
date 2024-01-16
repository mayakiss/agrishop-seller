// To parse this JSON data, do
//
//     final wholesaleProductDetailsResponse = wholesaleProductDetailsResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_ecommerce_seller_app/data_model/uploaded_file_list_response.dart';

WholesaleProductDetailsResponse wholesaleProductDetailsResponseFromJson(
        String str) =>
    WholesaleProductDetailsResponse.fromJson(json.decode(str));

String wholesaleProductDetailsResponseToJson(
        WholesaleProductDetailsResponse data) =>
    json.encode(data.toJson());

class WholesaleProductDetailsResponse {
  WholesaleProductDetails? data;
  bool? result;
  var status;

  WholesaleProductDetailsResponse({
    this.data,
    this.result,
    this.status,
  });

  factory WholesaleProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      WholesaleProductDetailsResponse(
        data: WholesaleProductDetails.fromJson(json["data"]),
        result: json["result"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "result": result,
        "status": status,
      };
}

class WholesaleProductDetails {
  var id;
  dynamic lang;
  String? productName;
  String? productUnit;
  dynamic description;
  var categoryId;
  List? categoryIds;
  dynamic brandId;
  UploadedFilesListResponse? photos;
  UploadedFilesListResponse? thumbnailImg;
  String? videoProvider;
  dynamic videoLink;
  String? tags;
  var unitPrice;
  dynamic purchasePrice;
  var variantProduct;
  List<dynamic>? attributes;
  List<dynamic>? choiceOptions;
  List<dynamic>? colors;
  dynamic variations;
  Stocks? stocks;
  var todaysDeal;
  var published;
  var approved;
  String? stockVisibilityState;
  var cashOnDelivery;
  var featured;
  var sellerFeatured;
  var currentStock;
  var weight;
  var minQty;
  var lowStockQuantity;
  dynamic discount;
  dynamic discountType;
  DateTime? discountStartDate;
  DateTime? discountEndDate;
  List<Tax>? tax;
  dynamic taxType;
  String? shippingType;
  var shippingCost;
  var isQuantityMultiplied;
  var refundable;
  dynamic estShippingDays;
  var numOfSale;
  String? metaTitle;
  String? metaDescription;
  UploadedFilesListResponse? metaImg;
  UploadedFilesListResponse? pdf;
  String? slug;
  dynamic barcode;
  dynamic fileName;
  dynamic filePath;
  dynamic externalLink;
  String? externalLinkBtn;
  List<WholesalePrice>? wholesalePrices;

  WholesaleProductDetails({
    this.id,
    this.lang,
    this.productName,
    this.productUnit,
    this.description,
    this.categoryId,
    this.categoryIds,
    this.brandId,
    this.photos,
    this.thumbnailImg,
    this.videoProvider,
    this.videoLink,
    this.tags,
    this.unitPrice,
    this.purchasePrice,
    this.variantProduct,
    this.attributes,
    this.choiceOptions,
    this.colors,
    this.variations,
    this.stocks,
    this.todaysDeal,
    this.published,
    this.approved,
    this.stockVisibilityState,
    this.cashOnDelivery,
    this.featured,
    this.sellerFeatured,
    this.currentStock,
    this.weight,
    this.minQty,
    this.lowStockQuantity,
    this.discount,
    this.discountType,
    this.discountStartDate,
    this.discountEndDate,
    this.tax,
    this.taxType,
    this.shippingType,
    this.shippingCost,
    this.isQuantityMultiplied,
    this.refundable,
    this.estShippingDays,
    this.numOfSale,
    this.metaTitle,
    this.metaDescription,
    this.metaImg,
    this.pdf,
    this.slug,
    this.barcode,
    this.fileName,
    this.filePath,
    this.externalLink,
    this.externalLinkBtn,
    this.wholesalePrices,
  });

  factory WholesaleProductDetails.fromJson(Map<String, dynamic> json) =>
      WholesaleProductDetails(
        id: json["id"],
        lang: json["lang"],
        productName: json["product_name"],
        productUnit: json["product_unit"],
        description: json["description"],
        categoryId: json["category_id"],
        categoryIds: json["category_ids"],
        brandId: json["brand_id"],
        photos: UploadedFilesListResponse.fromJson(json["photos"]),
        thumbnailImg: UploadedFilesListResponse.fromJson(json["thumbnail_img"]),
        videoProvider: json["video_provider"],
        videoLink: json["video_link"],
        tags: json["tags"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"],
        variantProduct: json["variant_product"],
        stocks: Stocks.fromJson(json["stocks"]),
        todaysDeal: json["todays_deal"],
        published: json["published"],
        approved: json["approved"],
        stockVisibilityState: json["stock_visibility_state"],
        cashOnDelivery: json["cash_on_delivery"],
        featured: json["featured"],
        sellerFeatured: json["seller_featured"],
        currentStock: json["current_stock"],
        weight: json["weight"],
        minQty: json["min_qty"],
        lowStockQuantity: json["low_stock_quantity"],
        discount: json["discount"],
        discountType: json["discount_type"],
        discountStartDate: DateTime.parse(json["discount_start_date"]),
        discountEndDate: DateTime.parse(json["discount_end_date"]),
        tax: List<Tax>.from(json["tax"].map((x) => Tax.fromJson(x))),
        taxType: json["tax_type"],
        shippingType: json["shipping_type"],
        shippingCost: json["shipping_cost"],
        isQuantityMultiplied: json["is_quantity_multiplied"],
        refundable: json["refundable"],
        estShippingDays: json["est_shipping_days"],
        numOfSale: json["num_of_sale"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaImg: UploadedFilesListResponse.fromJson(json["meta_img"]),
        pdf: UploadedFilesListResponse.fromJson(json["pdf"]),
        slug: json["slug"],
        barcode: json["barcode"],
        fileName: json["file_name"],
        filePath: json["file_path"],
        externalLink: json["external_link"],
        externalLinkBtn: json["external_link_btn"],
        wholesalePrices: List<WholesalePrice>.from(
            json["wholesale_prices"].map((x) => WholesalePrice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lang": lang,
        "product_name": productName,
        "product_unit": productUnit,
        "description": description,
        "category_id": categoryId,
        "category_ids": categoryIds,
        "brand_id": brandId,
        "photos": photos!.toJson(),
        "thumbnail_img": thumbnailImg!.toJson(),
        "video_provider": videoProvider,
        "video_link": videoLink,
        "tags": tags,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "variant_product": variantProduct,
        "attributes": List<dynamic>.from(attributes?.map((x) => x) ?? []),
        "choice_options":
            List<dynamic>.from(choiceOptions?.map((x) => x) ?? []),
        "colors": List<dynamic>.from(colors?.map((x) => x) ?? []),
        "variations": variations,
        "stocks": stocks!.toJson(),
        "todays_deal": todaysDeal,
        "published": published,
        "approved": approved,
        "stock_visibility_state": stockVisibilityState,
        "cash_on_delivery": cashOnDelivery,
        "featured": featured,
        "seller_featured": sellerFeatured,
        "current_stock": currentStock,
        "weight": weight,
        "min_qty": minQty,
        "low_stock_quantity": lowStockQuantity,
        "discount": discount,
        "discount_type": discountType,
        "discount_start_date":
            "${discountStartDate!.year.toString().padLeft(4, '0')}-${discountStartDate!.month.toString().padLeft(2, '0')}-${discountStartDate!.day.toString().padLeft(2, '0')}",
        "discount_end_date":
            "${discountEndDate!.year.toString().padLeft(4, '0')}-${discountEndDate!.month.toString().padLeft(2, '0')}-${discountEndDate!.day.toString().padLeft(2, '0')}",
        "tax": List<dynamic>.from(tax!.map((x) => x.toJson())),
        "tax_type": taxType,
        "shipping_type": shippingType,
        "shipping_cost": shippingCost,
        "is_quantity_multiplied": isQuantityMultiplied,
        "refundable": refundable,
        "est_shipping_days": estShippingDays,
        "num_of_sale": numOfSale,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_img": metaImg!.toJson(),
        "pdf": pdf!.toJson(),
        "slug": slug,
        "barcode": barcode,
        "file_name": fileName,
        "file_path": filePath,
        "external_link": externalLink,
        "external_link_btn": externalLinkBtn,
        "wholesale_prices":
            List<dynamic>.from(wholesalePrices!.map((x) => x.toJson())),
      };
}

class Stocks {
  List<StocksDatum>? data;

  Stocks({
    this.data,
  });

  factory Stocks.fromJson(Map<String, dynamic> json) => Stocks(
        data: List<StocksDatum>.from(
            json["data"].map((x) => StocksDatum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class StocksDatum {
  var id;
  var productId;
  String? variant;
  dynamic sku;
  var price;
  var qty;
  FileInfo? image;

  StocksDatum({
    this.id,
    this.productId,
    this.variant,
    this.sku,
    this.price,
    this.qty,
    this.image,
  });

  factory StocksDatum.fromJson(Map<String, dynamic> json) => StocksDatum(
        id: json["id"],
        productId: json["product_id"],
        variant: json["variant"],
        sku: json["sku"],
        price: json["price"],
        qty: json["qty"],
        image: FileInfo.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "variant": variant,
        "sku": sku,
        "price": price,
        "qty": qty,
        "image": image!.toJson(),
      };
}

class Tax {
  var id;
  var productId;
  var taxId;
  var tax;
  String? taxType;
  DateTime? createdAt;
  DateTime? updatedAt;

  Tax({
    this.id,
    this.productId,
    this.taxId,
    this.tax,
    this.taxType,
    this.createdAt,
    this.updatedAt,
  });

  factory Tax.fromJson(Map<String, dynamic> json) => Tax(
        id: json["id"],
        productId: json["product_id"],
        taxId: json["tax_id"],
        tax: json["tax"],
        taxType: json["tax_type"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "tax_id": taxId,
        "tax": tax,
        "tax_type": taxType,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class WholesalePrice {
  var id;
  var productStockId;
  var minQty;
  var maxQty;
  var price;
  DateTime? createdAt;
  DateTime? updatedAt;

  WholesalePrice({
    this.id,
    this.productStockId,
    this.minQty,
    this.maxQty,
    this.price,
    this.createdAt,
    this.updatedAt,
  });

  factory WholesalePrice.fromJson(Map<String, dynamic> json) => WholesalePrice(
        id: json["id"],
        productStockId: json["product_stock_id"],
        minQty: json["min_qty"],
        maxQty: json["max_qty"],
        price: json["price"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_stock_id": productStockId,
        "min_qty": minQty,
        "max_qty": maxQty,
        "price": price,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}
