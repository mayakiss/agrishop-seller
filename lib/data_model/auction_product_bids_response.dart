// To parse this JSON data, do
//
//     final auctionProductBids = auctionProductBidsFromJson(jsonString);

import 'dart:convert';

AuctionProductBids auctionProductBidsFromJson(String str) =>
    AuctionProductBids.fromJson(json.decode(str));

String auctionProductBidsToJson(AuctionProductBids data) =>
    json.encode(data.toJson());

class AuctionProductBids {
  List<AuctionBidCustomerList>? data;
  Links? links;
  Meta? meta;
  bool? success;
  int? status;

  AuctionProductBids({
    this.data,
    this.links,
    this.meta,
    this.success,
    this.status,
  });

  factory AuctionProductBids.fromJson(Map<String, dynamic> json) =>
      AuctionProductBids(
        data: json["data"] == null
            ? []
            : List<AuctionBidCustomerList>.from(
                json["data"]!.map((x) => AuctionBidCustomerList.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
        meta: json["meta"] == null ? null : Meta.fromJson(json["meta"]),
        success: json["success"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "links": links?.toJson(),
        "meta": meta?.toJson(),
        "success": success,
        "status": status,
      };
}

class AuctionBidCustomerList {
  int? id;
  String? customerName;
  String? customerEmail;
  String? customerPhone;
  String? biddedAmout;
  String? date;

  AuctionBidCustomerList({
    this.id,
    this.customerName,
    this.customerEmail,
    this.customerPhone,
    this.biddedAmout,
    this.date,
  });

  factory AuctionBidCustomerList.fromJson(Map<String, dynamic> json) =>
      AuctionBidCustomerList(
        id: json["id"],
        customerName: json["customer_name"],
        customerEmail: json["customer_email"],
        customerPhone: json["customer_phone"],
        biddedAmout: json["bidded_amout"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "customer_name": customerName,
        "customer_email": customerEmail,
        "customer_phone": customerPhone,
        "bidded_amout": biddedAmout,
        "date": date,
      };
}

class Links {
  String? first;
  String? last;
  dynamic prev;
  dynamic next;

  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  factory Links.fromJson(Map<String, dynamic> json) => Links(
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
