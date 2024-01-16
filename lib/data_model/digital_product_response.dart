// To parse this JSON data, do
//
//     final digitalProductResponse = digitalProductResponseFromJson(jsonString);

import 'dart:convert';

DigitalProductResponse digitalProductResponseFromJson(String str) =>
    DigitalProductResponse.fromJson(json.decode(str));

String digitalProductResponseToJson(DigitalProductResponse data) =>
    json.encode(data.toJson());

class DigitalProductResponse {
  List<Datum>? data;
  Links? links;
  Meta? meta;

  DigitalProductResponse({
    this.data,
    this.links,
    this.meta,
  });

  factory DigitalProductResponse.fromJson(Map<String, dynamic> json) =>
      DigitalProductResponse(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        links: json["links"] == null ? null : Links.fromJson(json["links"]),
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

class Datum {
  int? id;
  String? name;
  String? thumbnailImg;
  String? category;
  int? price;
  bool? status;
  bool? featured;

  Datum({
    this.id,
    this.name,
    this.thumbnailImg,
    this.category,
    this.price,
    this.status,
    this.featured,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        thumbnailImg: json["thumbnail_img"],
        category: json["category"],
        price: json["price\t"],
        status: json["status"],
        featured: json["featured"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "thumbnail_img": thumbnailImg,
        "category": category,
        "price\t": price,
        "status": status,
        "featured": featured,
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
