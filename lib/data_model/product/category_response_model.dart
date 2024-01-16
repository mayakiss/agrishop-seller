// To parse this JSON data, do
//
//     final categoryResponse = categoryResponseFromJson(jsonString);

import 'dart:convert';

CategoryResponse categoryResponseFromJson(String str) => CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) => json.encode(data.toJson());

class CategoryResponse {
  CategoryResponse({
     this.data,
  });

  List<Category>? data;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) => CategoryResponse(
    data: List<Category>.from(json["data"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "data": List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class Category {
  Category({
     this.id,
     this.parentId,
     this.level,
     this.name,
     this.banner,
     this.icon,
     this.featured,
     this.digital,
     this.child,
  });

  var id;
  var parentId;
  var level;
  String? name;
  String? banner;
  String? icon;
  bool? featured;
  bool? digital;
  List<Category>? child;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    parentId: json["parent_id"],
    level: int.parse(json["level"].toString()),
    name: json["name"],
    banner: json["banner"],
    icon: json["icon"],
    featured: json["featured"],
    digital: json["digital"],
    child: List<Category>.from(json["child"].map((x) => Category.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "parent_id": parentId,
    "level": level,
    "name": name,
    "banner": banner,
    "icon": icon,
    "featured": featured,
    "digital": digital,
    "child": List<dynamic>.from(child!.map((x) => x.toJson())),
  };
}
