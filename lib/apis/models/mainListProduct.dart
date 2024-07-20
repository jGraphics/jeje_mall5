import 'dart:convert';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';
// To parse this JSON data, do
//
//     final MainProduct = MainProductFromJson(jsonString);



MainProduct mainProductFromJson(String str) =>
    MainProduct.fromJson(json.decode(str));

String mainProductToJson(MainProduct data) => json.encode(data.toJson());

class MainProduct {
  int page;
  int size;
  int total;
  dynamic debug;
  dynamic previousPage;
  dynamic nextPage;
  List<Item> items;

  MainProduct({
    required this.page,
    required this.size,
    required this.total,
    this.debug,
    this.previousPage,
    this.nextPage,
    required this.items,
  });

  factory MainProduct.fromJson(Map<String, dynamic> json) => MainProduct(
        page: json["page"],
        size: json["size"],
        total: json["total"],
        debug: json["debug"],
        previousPage: json["previous_page"],
        nextPage: json["next_page"],
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "page": page,
        "size": size,
        "total": total,
        "debug": debug,
        "previous_page": previousPage,
        "next_page": nextPage,
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
      };
}

Item singleItemFromJson(String str) => Item.fromJson(json.decode(str));

String singleItemToJson(Item data) => json.encode(data.toJson());
