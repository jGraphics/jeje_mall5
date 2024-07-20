import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';


class Timbu {
  String productUrl = 'https://api.timbu.cloud/products';
  String catUrl = 'https://api.timbu.cloud/categories';
  String appId = 'W9X4OK6Q2OE8CCD';
  String apiKey = 'f25077d253824a08945101df19f880fc20240712161828370421';
  String organizationId = 'd7535f6ea5924161ba32c2d855cc5a0f';
  String womenId = '968ff0c1422c4e66affb21378bf3d95a';
  String menId = '875fc9f4990c472d815cc27513344906';
  String techId = 'e87e8d791f804bfda5bd34ba7d53076d';

  Future<List<Item>> fetchProductsByCategoryId(String categoryId) async {
    final response = await http.get(
      Uri.parse('$productUrl?organization_id=$organizationId&Appid=$appId&Apikey=$apiKey&category_id=$categoryId&size=12&page=1'),
    );

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body);
      final List<Item> items = (jsonData['items'] as List)
          .map((item) => Item.fromJson(item))
          .toList();
      return items;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
// https://api.timbu.cloud/products?&organization_id=d7535f6ea5924161ba32c2d855cc5a0f&Appid=W9X4OK6Q2OE8CCD&Apikey=f25077d253824a08945101df19f880fc20240712161828370421&category=Women%27s-Fashion

