import 'dart:convert';

List<Category> categoryFromJson(String str) =>
    List<Category>.from(json.decode(str).map((x) => Category.fromJson(x)));

String categoryToJson(List<Category> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Category {
  Category({
    this.id,
    this.category,
    this.v,
  });

  String id;
  String category;
  int v;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        category: json["category"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category": category,
        "__v": v,
      };
}
