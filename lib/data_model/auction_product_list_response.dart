import 'dart:convert';

AuctionProductListResponse auctionProductListResponseFromJson(String str) =>
    AuctionProductListResponse.fromJson(json.decode(str));

String auctionProductListResponseToJson(AuctionProductListResponse data) =>
    json.encode(data.toJson());

class AuctionProductListResponse {
  List<AuctionProductModel>? data;
  AuctionProductListResponseLinks? links;
  Meta? meta;

  AuctionProductListResponse({
    this.data,
    this.links,
    this.meta,
  });

  factory AuctionProductListResponse.fromJson(Map<String, dynamic> json) =>
      AuctionProductListResponse(
        data: json["data"] == null
            ? []
            : List<AuctionProductModel>.from(
                json["data"]!.map((x) => AuctionProductModel.fromJson(x))),
        links: json["links"] == null
            ? null
            : AuctionProductListResponseLinks.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
      };
}

class AuctionProductModel {
  int? id;
  String? name;
  String? thumbnailImage;
  String? mainPrice;
  DateTime? startDate;
  DateTime? endDate;
  int? totalBids;
  bool? canEdit;
  Links? links;

  AuctionProductModel({
    this.id,
    this.name,
    this.thumbnailImage,
    this.mainPrice,
    this.startDate,
    this.endDate,
    this.totalBids,
    this.canEdit,
    this.links,
  });

  factory AuctionProductModel.fromJson(Map<String, dynamic> json) =>
      AuctionProductModel(
        id: json["id"],
        name: json["name"],
        thumbnailImage: json["thumbnail_image"],
        mainPrice: json["main_price"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        endDate:
            json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
        totalBids: json["total_bids"],
        canEdit: json["can_edit"],
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail_image": thumbnailImage,
        "main_price": mainPrice,
        "start_date": startDate?.toIso8601String(),
        "end_date": endDate?.toIso8601String(),
        "total_bids": totalBids,
        "can_edit": canEdit,
        "links": links?.toJson(),
      };
}

class Links {
  String? details;

  Links({
    this.details,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        details: json["details"],
      );

  Map<String, dynamic> toJson() => {
        "details": details,
      };
}

class AuctionProductListResponseLinks {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  AuctionProductListResponseLinks({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory AuctionProductListResponseLinks.fromJson(Map<String, dynamic> json) =>
      AuctionProductListResponseLinks(
        first: json["first"],
        last: json["last"],
        prev: json["prev"],
        next: json["next"],
      );

  Map<String, dynamic> toJson() => {
        "first": first,
        "last": last,
        "prev": prev,
        "next": next,
      };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  factory Meta.fromJson(Map<String, dynamic> json) => Meta(
        currentPage: json["current_page"],
        from: json["from"],
        lastPage: json["last_page"],
        links: json["links"] == null
            ? []
            : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
        path: json["path"],
        perPage: json["per_page"],
        to: json["to"],
        total: json["total"],
      );

  Map<String, dynamic> toJson() => {
        "current_page": currentPage,
        "from": from,
        "last_page": lastPage,
        "links": links == null
            ? []
            : List<dynamic>.from(links!.map((x) => x.toJson())),
        "path": path,
        "per_page": perPage,
        "to": to,
        "total": total,
      };
}

class Link {
  String? url;
  String? label;
  bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
        url: json["url"],
        label: json["label"],
        active: json["active"],
      );

  Map<String, dynamic> toJson() => {
        "url": url,
        "label": label,
        "active": active,
      };
}
