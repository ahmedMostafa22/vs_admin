import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:vs_admin/models/order.dart';
import 'package:vs_admin/models/product.dart';
import 'package:vs_admin/models/user.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> orders = [];
  bool ordersLoading = false;
  Future<void> getOrders() async {
    ordersLoading = true;
    notifyListeners();
    orders.clear();
    final url =
        'https://virtualmall-5a21c-default-rtdb.firebaseio.com/Orders.json?orderBy="time"';
    return http.get(url).catchError((onError) {
      ordersLoading = false;
      notifyListeners();
      throw onError;
    }).then((response) {
      print(response.body);
      if (response != null) {
        Map<String, dynamic> ordersData = json.decode(response.body);
        ordersData.forEach((key, order) {
          List<String> itemsList = extractItems(order['items']);
          List<Product> products = [];

          for (int i = 0; i < itemsList.length; i++)
            products.add(Product(
                dbId: json.decode(itemsList[i])['productId'],
                colors: json.decode(itemsList[i])['color'],
                size: json.decode(itemsList[i])['size'],
                quantity: json.decode(itemsList[i])['quantity']));
          orders.add(Order(
            id: key,
            time: order['time'],
            totalCost: order['totalCost'],
            storeId: order['storeId'],
            uId: order['uId'],
            items: products,
          ));
        });
        ordersLoading = false;
        notifyListeners();
      }
    });
  }

  List<String> extractItems(String encodedString) {
    List<String> result = [];
    int start = 0;
    for (int i = 0; i < encodedString.length; i++) {
      if (encodedString[i] == "{")
        start = i;
      else if (encodedString[i] == "}")
        result.add(encodedString.substring(start, i + 1));
    }
    return result;
  }

  Future<StoreUser> getOrderCustomer(String id) async {
    final url =
        'https://virtualmall-5a21c-default-rtdb.firebaseio.com/Users/$id.json';
    final http.Response res = await http.get(url);
    print(json.decode(res.body));
    return StoreUser(
        email: json.decode(res.body)['email'], id: json.decode(res.body)['id']);
  }
}
