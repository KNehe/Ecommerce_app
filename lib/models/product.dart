import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.name,
    this.price,
    this.imageUrl,
    this.category,
    this.details,
    this.v,
  });

  String id;
  String name;
  int price;
  String imageUrl;
  String category;
  String details;
  int v;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["_id"],
        name: json["name"],
        price: json["price"],
        imageUrl: json["imageUrl"],
        category: json["category"],
        details: json["details"],
        v: json["__v"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "price": price,
        "imageUrl": imageUrl,
        "category": category,
        "details": details,
        "__v": v,
      };
}
