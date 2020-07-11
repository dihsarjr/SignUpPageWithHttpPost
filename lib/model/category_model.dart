// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.response,
    this.data,
    this.message,
  });

  bool response;
  List<Datum> data;
  String message;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        response: json["response"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "response": response,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "message": message,
      };
}

class Datum {
  Datum({
    this.categorygroup,
  });

  Categorygroup categorygroup;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        categorygroup: Categorygroup.fromJson(json["categorygroup"]),
      );

  Map<String, dynamic> toJson() => {
        "categorygroup": categorygroup.toJson(),
      };
}

class Categorygroup {
  Categorygroup({
    this.id,
    this.name,
    this.slug,
    this.description,
    this.icon,
    this.img,
    this.categorySubGroup,
    this.categories,
  });

  int id;
  String name;
  String slug;
  String description;
  Icon icon;
  String img;
  List<CategorySubGroupElement> categorySubGroup;
  List<CategorySubGroupElement> categories;

  factory Categorygroup.fromJson(Map<String, dynamic> json) => Categorygroup(
        id: json["id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"],
        icon: Icon.fromJson(json["icon"]),
        img: json["img"],
        categorySubGroup: List<CategorySubGroupElement>.from(
            json["category_sub_group"]
                .map((x) => CategorySubGroupElement.fromJson(x))),
        categories: json["categories"] == null
            ? null
            : List<CategorySubGroupElement>.from(json["categories"]
                .map((x) => CategorySubGroupElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "slug": slug,
        "description": description,
        "icon": icon.toJson(),
        "img": img,
        "category_sub_group":
            List<dynamic>.from(categorySubGroup.map((x) => x.toJson())),
        "categories": categories == null
            ? null
            : List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

class CategorySubGroupElement {
  CategorySubGroupElement({
    this.id,
    this.categorySubGrpId,
    this.name,
    this.slug,
    this.description,
    this.img,
    this.categoryGroupId,
  });

  int id;
  int categorySubGrpId;
  String name;
  String slug;
  String description;
  String img;
  int categoryGroupId;

  factory CategorySubGroupElement.fromJson(Map<String, dynamic> json) =>
      CategorySubGroupElement(
        id: json["id"],
        categorySubGrpId: json["category_sub_grp_id"] == null
            ? null
            : json["category_sub_grp_id"],
        name: json["name"],
        slug: json["slug"],
        description: json["description"] == null ? null : json["description"],
        img: json["img"],
        categoryGroupId: json["category_group_id"] == null
            ? null
            : json["category_group_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "category_sub_grp_id":
            categorySubGrpId == null ? null : categorySubGrpId,
        "name": name,
        "slug": slug,
        "description": description == null ? null : description,
        "img": img,
        "category_group_id": categoryGroupId == null ? null : categoryGroupId,
      };
}

class Icon {
  Icon();

  factory Icon.fromJson(Map<String, dynamic> json) => Icon();

  Map<String, dynamic> toJson() => {};
}
