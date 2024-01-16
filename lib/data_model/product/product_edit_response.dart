// To parse this JSON data, do
//
//     final productEditResponse = productEditResponseFromJson(jsonString);

import 'dart:convert';

import 'package:active_ecommerce_seller_app/data_model/uploaded_file_list_response.dart';

ProductEditResponse productEditResponseFromJson(String str) =>
    ProductEditResponse.fromJson(json.decode(str));

String productEditResponseToJson(ProductEditResponse data) =>
    json.encode(data.toJson());

class ProductEditResponse {
  ProductEditResponse({
    this.data,
    this.result,
    this.status,
  });

  ProductInfo? data;
  bool? result;
  var status;

  factory ProductEditResponse.fromJson(Map<String, dynamic> json) =>
      ProductEditResponse(
        data: ProductInfo.fromJson(json["data"]),
        result: json["result"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data!.toJson(),
        "result": result,
        "status": status,
      };
}

class ProductInfo {
  ProductInfo({
    this.id,
    this.lang,
    this.productName,
    this.productUnit,
    this.description,
    this.categoryId,
    this.categories = const [],
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
    this.refundable,
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
    this.estShippingDays,
    this.numOfSale,
    this.metaTitle,
    this.metaDescription,
    this.metaImg,
    this.pdf,
    this.slug,
    this.rating,
    this.barcode,
    this.digital,
    this.auctionProduct,
    this.fileName,
    this.filePath,
    this.externalLink,
    this.externalLinkBtn,
    this.wholesaleProduct,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  String? lang;
  String? productName;
  String? productUnit;
  dynamic description;
  var categoryId;
  List categories;
  dynamic brandId;
  Photos? photos;
  Photos? thumbnailImg;
  String? videoProvider;
  dynamic videoLink;
  String? tags;
  var unitPrice;
  dynamic purchasePrice;
  var variantProduct;
  List<String>? attributes;
  List<ChoiceOption>? choiceOptions;
  List<String>? colors;
  dynamic variations;
  Stock? stocks;
  var todaysDeal;
  var published;
  var approved;
  String? stockVisibilityState;
  var cashOnDelivery;
  var featured;
  var sellerFeatured;
  var refundable;
  var currentStock;
  var weight;
  var minQty;
  var lowStockQuantity;
  var discount;
  String? discountType;
  var discountStartDate;
  var discountEndDate;
  List<Tax>? tax;
  dynamic taxType;
  String? shippingType;
  var shippingCost;
  var isQuantityMultiplied;
  dynamic estShippingDays;
  var numOfSale;
  String? metaTitle;
  String? metaDescription;
  Photos? metaImg;
  Photos? pdf;
  String? slug;
  var rating;
  dynamic barcode;
  var digital;
  var auctionProduct;
  dynamic fileName;
  dynamic filePath;
  dynamic externalLink;
  dynamic externalLinkBtn;
  var wholesaleProduct;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory ProductInfo.fromJson(Map<String, dynamic> json) => ProductInfo(
        id: json["id"],
        lang: json["lang"],
        productName: json["product_name"],
        productUnit: json["product_unit"],
        description: json["description"],
        categoryId: json["category_id"],
        categories: json["category_ids"],
        brandId: json["brand_id"],
        photos: Photos.fromJson(json["photos"]),
        thumbnailImg: Photos.fromJson(json["thumbnail_img"]),
        videoProvider: json["video_provider"],
        videoLink: json["video_link"],
        tags: json["tags"],
        unitPrice: json["unit_price"],
        purchasePrice: json["purchase_price"],
        variantProduct: json["variant_product"],
        attributes: List<String>.from(json["attributes"].map((x) => x)),
        choiceOptions: List<ChoiceOption>.from(
            json["choice_options"].map((x) => ChoiceOption.fromJson(x))),
        colors: List<String>.from(json["colors"].map((x) => x)),
        variations: json["variations"],
        stocks: Stock.fromJson(json["stocks"]),
        todaysDeal: json["todays_deal"],
        published: json["published"],
        approved: json["approved"],
        stockVisibilityState: json["stock_visibility_state"],
        cashOnDelivery: json["cash_on_delivery"],
        featured: json["featured"],
        sellerFeatured: json["seller_featured"] ?? 0,
        refundable: json["refundable"],
        currentStock: json["current_stock"],
        weight: json["weight"],
        minQty: json["min_qty"],
        lowStockQuantity: json["low_stock_quantity"],
        discount: json["discount"],
        discountType: json["discount_type"],
        discountStartDate: json["discount_start_date"],
        discountEndDate: json["discount_end_date"],
        tax: List<Tax>.from(json["tax"].map((x) => Tax.fromJson(x))),
        taxType: json["tax_type"],
        shippingType: json["shipping_type"],
        shippingCost: json["shipping_cost"],
        isQuantityMultiplied: json["is_quantity_multiplied"],
        estShippingDays: json["est_shipping_days"],
        numOfSale: json["num_of_sale"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        // metaImg: json["meta_img"],
        metaImg: Photos.fromJson(json["meta_img"]),
        pdf: Photos.fromJson(json["pdf"]),
        slug: json["slug"],
        rating: json["rating"],
        barcode: json["barcode"],
        digital: json["digital"],
        auctionProduct: json["auction_product"],
        fileName: json["file_name"],
        filePath: json["file_path"],
        externalLink: json["external_link"],
        externalLinkBtn: json["external_link_btn"],
        wholesaleProduct: json["wholesale_product"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lang": lang,
        "product_name": productName,
        "product_unit": productUnit,
        "description": description,
        "category_id": categoryId,
        "category_ids": categories,
        "brand_id": brandId,
        "photos": photos!.toJson(),
        "thumbnail_img": thumbnailImg!.toJson(),
        "video_provider": videoProvider,
        "video_link": videoLink,
        "tags": tags,
        "unit_price": unitPrice,
        "purchase_price": purchasePrice,
        "variant_product": variantProduct,
        "attributes": List<dynamic>.from(attributes!.map((x) => x)),
        "choice_options":
            List<dynamic>.from(choiceOptions!.map((x) => x.toJson())),
        "colors": List<dynamic>.from(colors!.map((x) => x)),
        "variations": variations,
        "stocks": stocks!.toJson(),
        "todays_deal": todaysDeal,
        "published": published,
        "approved": approved,
        "stock_visibility_state": stockVisibilityState,
        "cash_on_delivery": cashOnDelivery,
        "featured": featured,
        "seller_featured": sellerFeatured,
        "refundable": refundable,
        "current_stock": currentStock,
        "weight": weight,
        "min_qty": minQty,
        "low_stock_quantity": lowStockQuantity,
        "discount": discount,
        "discount_type": discountType,
        "discount_start_date": discountStartDate,
        "discount_end_date": discountEndDate,
        "tax": List<dynamic>.from(tax!.map((x) => x.toJson())),
        "tax_type": taxType,
        "shipping_type": shippingType,
        "shipping_cost": shippingCost,
        "is_quantity_multiplied": isQuantityMultiplied,
        "est_shipping_days": estShippingDays,
        "num_of_sale": numOfSale,
        "meta_title": metaTitle,
        "meta_description": metaDescription,
        "meta_img": metaImg!.toJson(),
        "pdf": pdf!.toJson(),
        "slug": slug,
        "rating": rating,
        "barcode": barcode,
        "digital": digital,
        "auction_product": auctionProduct,
        "file_name": fileName,
        "file_path": filePath,
        "external_link": externalLink,
        "external_link_btn": externalLinkBtn,
        "wholesale_product": wholesaleProduct,
        "created_at": createdAt!.toIso8601String(),
        "updated_at": updatedAt!.toIso8601String(),
      };
}

class ChoiceOption {
  ChoiceOption({
    this.attributeId,
    this.values,
  });

  String? attributeId;
  List<String>? values;

  factory ChoiceOption.fromJson(Map<String, dynamic> json) => ChoiceOption(
        attributeId: json["attribute_id"],
        values: List<String>.from(json["values"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "attribute_id": attributeId,
        "values": List<dynamic>.from(values!.map((x) => x)),
      };
}

class StockValues {
  StockValues({
    this.id,
    this.fileOriginalName,
    this.fileName,
    this.url,
    this.fileSize,
    this.extension,
    this.type,
    this.productId,
    this.variant,
    this.sku,
    this.price,
    this.qty,
    this.image,
  });

  var id;
  String? fileOriginalName;
  String? fileName;
  String? url;
  var fileSize;
  String? extension;
  String? type;
  var productId;
  String? variant;
  String? sku;
  var price;
  var qty;
  Photos? image;

  factory StockValues.fromJson(Map<String, dynamic> json) => StockValues(
        id: json["id"],
        fileOriginalName: json["file_original_name"],
        fileName: json["file_name"],
        url: json["url"],
        fileSize: json["file_size"],
        extension: json["extension"],
        type: json["type"],
        productId: json["product_id"],
        variant: json["variant"],
        sku: json["sku"],
        price: json["price"],
        qty: json["qty"],
        image: json["image"] == null ? null : Photos.fromJson(json["image"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "file_original_name": fileOriginalName,
        "file_name": fileName,
        "url": url,
        "file_size": fileSize,
        "extension": extension,
        "type": type,
        "product_id": productId,
        "variant": variant,
        "sku": sku,
        "price": price,
        "qty": qty,
        "image": image!.toJson(),
      };
}

class Photos {
  Photos({
    this.data,
  });

  List<FileInfo>? data;

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
        data:
            List<FileInfo>.from(json["data"].map((x) => FileInfo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Stock {
  Stock({
    this.data,
  });

  List<StockValues>? data;

  factory Stock.fromJson(Map<String, dynamic> json) => Stock(
        data: List<StockValues>.from(
            json["data"].map((x) => StockValues.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
      };
}

class Tax {
  Tax({
    this.id,
    this.productId,
    this.taxId,
    this.tax,
    this.taxType,
    this.createdAt,
    this.updatedAt,
  });

  var id;
  var productId;
  var taxId;
  var tax;
  String? taxType;
  DateTime? createdAt;
  DateTime? updatedAt;

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
