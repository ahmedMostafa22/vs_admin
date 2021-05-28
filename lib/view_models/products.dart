import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vs_admin/models/product.dart';
import 'package:http/http.dart' as http;

class ProductsProvider with ChangeNotifier {
  List<Product> products = [];
  bool productsLoading = false;

  Future<Product> getProductData(String id) async {
    final url =
        'https://virtualmall-5a21c-default-rtdb.firebaseio.com/Products/$id.json';
    final http.Response res = await http.get(url);
    return Product.fromJson(json.decode(res.body));
  }

  Future<void> getProducts() async {
    productsLoading = true;
    notifyListeners();
    products.clear();
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
          products.add(Product.fromJson(product));
        });
        productsLoading = false;
        notifyListeners();
      }
    });
  }
}
