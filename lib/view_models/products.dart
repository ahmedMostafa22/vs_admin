import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/constants.dart';
import 'package:vs_admin/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:vs_admin/view_models/stores.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> products = [];
  bool productsLoading = false;

  Future<Product> getProductData(String id) async {
    final url =
        'https://virtualmall-5a21c-default-rtdb.firebaseio.com/Products/$id.json';
    final http.Response res = await http.get(url);
    return Product.fromJson(json.decode(res.body));
  }

  Future<void> getProducts(BuildContext context) async {
    if (products.isNotEmpty) return;
    productsLoading = true;
    notifyListeners();
    final url =
        'https://virtualmall-5a21c-default-rtdb.firebaseio.com/Products.json';
    return http.get(url).catchError((onError) {
      productsLoading = false;
      notifyListeners();
      throw onError;
    }).then((response) {
      print(response.body);
      if (response != null) {
        Map<String, dynamic> productsData = json.decode(response.body);
        productsData.forEach((key, product) {
          if (Provider.of<StoresProvider>(context, listen: false)
              .stores
              .where(
                  (element) => element.id == Product.fromJson(product).storeId)
              .toList()
              .isNotEmpty) products.add(Product.fromJson(product));
        });
        productsLoading = false;
        notifyListeners();
      }
    });
  }

  Future updateProduct(Product product) async {
    final url =
        'https://virtualmall-5a21c-default-rtdb.firebaseio.com/Products/${product.dbId}.json';
    print(product.toJson());
    return http
        .patch(url, body: json.encode(product.toJson()))
        .catchError((onError) {
      print(onError.toString());
    }).then((response) {
      print(response.body);
      int updateIndex =
          products.indexWhere((element) => element.dbId == product.dbId);
      products[updateIndex] = product;
      Fluttertoast.showToast(
          msg: 'Product Updated', backgroundColor: Constants.primaryColor);
      notifyListeners();
    });
  }
}
