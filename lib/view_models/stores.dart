import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:vs_admin/models/store.dart';
import 'package:http/http.dart' as http;

class StoresProvider with ChangeNotifier {
  List<Store> stores = [];
  bool loadingStores = false;

  Future<void> getStores() async {
    loadingStores = true;
    notifyListeners();
    stores.clear();
    final url =
        'https://virtualmall-5a21c-default-rtdb.firebaseio.com/Stores.json';
    return http.get(url).catchError((onError) {
      loadingStores = false;
      notifyListeners();
      throw onError;
    }).then((response) {
      print(response.body);
      if (response != null) {
        Map<String, dynamic> storesData = json.decode(response.body);
        storesData.forEach((key, store) {
          stores.add(Store.fromJson(store));
        });
        loadingStores = false;
        notifyListeners();
      }
    });
  }
}
