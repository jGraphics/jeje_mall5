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
    var getTimbu =
        '${Timbu().productUrl}?organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}&reverse_sort=false&category=$category';
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
      throw Exception('Failed to load products by category');
    }
  }
}


// class TimbuApiProvider with ChangeNotifier {
//   bool _isLoading = false;
//   bool get loading => _isLoading;

//   void setLoading(bool value) {
//     _isLoading = value;
//     notifyListeners();
//   }
// Future<MainProduct> getProduct() async {
//     setLoading(true);
//     var getTimbu =
//         '${Timbu().productUrl}?&organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}';
//     if (kDebugMode) {
//       print(getTimbu);
//     }
//     var res = await http.get(
//       Uri.parse(getTimbu),
//       headers: {
//         'Content-Type': "application/json",
//       },
//     );

//     if (res.statusCode == 200) {
//       setLoading(false);
//       notifyListeners();
//       return mainProductFromJson(res.body);
//     } else {
//       setLoading(false);
//       notifyListeners();
//       return mainProductFromJson(res.body);
//     }
//   }

//   Future<Item> getAProduct(id) async {
//     setLoading(true);
//     var getTimbu =
//         '${Timbu().productUrl}/$id?&organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}';
//     if (kDebugMode) {
//       print(getTimbu);
//     }
//     var res = await http.get(
//       Uri.parse(getTimbu),
//       headers: {
//         'Content-Type': "application/json",
//       },
//     );

//     if (res.statusCode == 200) {
//       setLoading(false);
//       notifyListeners();
//       return singleItemFromJson(res.body);
//     } else {
//       setLoading(false);
//       notifyListeners();
//       return singleItemFromJson(res.body);
//     }
//   }


//   Future<MainProduct> getProductByCategory(String category) async {
//     setLoading(true);
//     var getTimbu = '${Timbu().productUrl}?organization_id=${Timbu().organizationId}&Appid=${Timbu().appId}&Apikey=${Timbu().apiKey}&reverse_sort=false&category=$category';
//     if (kDebugMode) {
//       print(getTimbu);
//     }
//     var res = await http.get(
//       Uri.parse(getTimbu),
//       headers: {
//         'Content-Type': "application/json",
//       },
//     );

//     if (res.statusCode == 200) {
//       setLoading(false);
//       return mainProductFromJson(res.body);
//     } else {
//       setLoading(false);
//       throw Exception('Failed to load products');
//     }
//   }
// }