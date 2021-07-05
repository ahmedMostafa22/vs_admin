import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/models/order.dart';
import 'package:vs_admin/models/product.dart';
import 'package:vs_admin/models/report.dart';
import 'package:vs_admin/models/user.dart';
import 'package:vs_admin/view_models/stores.dart';

class OrdersProvider with ChangeNotifier {
  List<Order> orders = [];
  bool ordersLoading = false;
  Report report;

  Future<void> getOrders(BuildContext context) async {
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
      if (response != null) {
        Map<String, dynamic> ordersData = json.decode(response.body);
        if (ordersData != null && ordersData.isNotEmpty)
          ordersData.forEach((key, order) {
            print('mystore:' +
                Provider.of<StoresProvider>(context, listen: false)
                    .stores[0]
                    .id);
            if (Provider.of<StoresProvider>(context, listen: false)
                .stores
                .where((element) => element.id == order['storeId'])
                .toList()
                .isNotEmpty) {
              List<Product> products = [];
              List<String> itemsList = extractItems(order['items']);

              for (int i = 0; i < itemsList.length; i++) {
                print(order['storeId']);
                products.add(Product(
                    dbId: json.decode(itemsList[i])['productId'],
                    colors: json.decode(itemsList[i])['color'],
                    size: json.decode(itemsList[i])['size'],
                    quantity: json.decode(itemsList[i])['quantity']));
              }
              orders.add(Order(
                id: key,
                time: order['time'],
                totalCost: order['totalCost'],
                storeId: order['storeId'],
                uId: order['uId'],
                items: products,
              ));
            }
          });
        ordersLoading = false;
        print(orders.length);
        notifyListeners();
      }
    });
  }

  Future<void> getReport(BuildContext context, String start, String end) async {
    ordersLoading = true;
    notifyListeners();
    List<Product> products = [];
    double totalPrice = 0.0;
    final url =
        'https://virtualmall-5a21c-default-rtdb.firebaseio.com/Orders.json?orderBy="time"';
    return http.get(url).catchError((onError) {
      ordersLoading = false;
      notifyListeners();
      throw onError;
    }).then((response) {
      if (response != null) {
        Map<String, dynamic> ordersData = json.decode(response.body);
        if (ordersData != null && ordersData.isNotEmpty)
          ordersData.forEach((key, order) {
            List<String> itemsList = extractItems(order['items']);
            if (Provider.of<StoresProvider>(context, listen: false)
                    .stores
                    .where((element) => element.id == order['storeId'])
                    .isNotEmpty &&
                validateDates(
                    start, end, order['time'].toString().substring(0, 10))) {
              for (int i = 0; i < itemsList.length; i++) {
                if (products.isEmpty ||
                    products
                        .where((element) =>
                            element.dbId ==
                            json.decode(itemsList[i])['productId'])
                        .toList()
                        .isEmpty)
                  products.add(Product(
                      dbId: json.decode(itemsList[i])['productId'],
                      colors: json.decode(itemsList[i])['color'],
                      size: json.decode(itemsList[i])['size'],
                      quantity: json.decode(itemsList[i])['quantity']));
                else
                  products[products.indexWhere((element) =>
                          element.dbId ==
                          json.decode(itemsList[i])['productId'])]
                      .quantity += json.decode(itemsList[i])['quantity'];
              }
              totalPrice += order['totalCost'];
            }
          });

        ordersLoading = false;
        report = Report(
            startDate: start,
            endDate: end,
            products: products,
            totalPrice: totalPrice);
        notifyListeners();
      }
    });
  }

  bool validateDates(String start, String end, String date) =>
      start.compareTo(date) <= 0 && end.compareTo(date) >= 0;

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
    return StoreUser(
        email: json.decode(res.body)['email'], id: json.decode(res.body)['id']);
  }
}
