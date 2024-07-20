import 'dart:convert';
import 'models/mainListProduct.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:jeje_mall5/apis/connectionUrl/apiUrl.dart';
import 'package:jeje_mall5/apis/models/listOfProductItem.dart';


class TimbuApiProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get loading => _isLoading;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<MainProduct> getProduct() async {
    setLoading(true);
    var getTimbu =
        '${Timbu().productUrl}?organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}';
    if (kDebugMode) {
      print(getTimbu);
    }
    var res = await http.get(
      Uri.parse(getTimbu),
      headers: {
        'Content-Type': "application/json",
      },
    );

    setLoading(false);
    if (res.statusCode == 200) {
      return mainProductFromJson(res.body);
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<Item> getAProduct(String id) async {
    setLoading(true);
    var getTimbu =
        '${Timbu().productUrl}/$id?organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}';
    if (kDebugMode) {
      print(getTimbu);
    }
    var res = await http.get(
      Uri.parse(getTimbu),
      headers: {
        'Content-Type': "application/json",
      },
    );

    setLoading(false);
    if (res.statusCode == 200) {
      return singleItemFromJson(res.body);
    } else {
      throw Exception('Failed to load product');
    }
  }

  Future<MainProduct> getProductByCategory(String category) async {
    setLoading(true);
    final String url =
        '${Timbu().productUrl}?organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}&reverse_sort=false&category=$category';
    
    if (kDebugMode) {
      print(url);
    }

    try {
      final response = await http.get(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
      );

      if (response.statusCode == 200) {
        return mainProductFromJson(response.body);
      } else {
        throw Exception('Failed to load products by category');
      }
    } finally {
      setLoading(false);
    }
  }

  Future<List<Item>> fetchProductsByCategoryId(String categoryId) async {
    setLoading(true);
    final response = await http.get(
      Uri.parse('${Timbu().productUrl}?organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}&category_id=$categoryId&size=12&page=1'),
    );

    setLoading(false);
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