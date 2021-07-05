import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:vs_admin/models/store.dart';
import 'package:http/http.dart' as http;

import '../constants.dart';

class StoresProvider with ChangeNotifier {
  List<Store> stores = [];
  bool loadingStores = false;

  Future<void> getStores() async {
    if(stores.isNotEmpty)return ;
    loadingStores = true;
    notifyListeners();
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
          if(Store.fromJson(store).ownerId==FirebaseAuth.instance.currentUser.uid)
          stores.add(Store.fromJson(store));
        });
        loadingStores = false;
        notifyListeners();
      }
    });
  }


  Future updateStore(Store store) async {
    final url =
        'https://virtualmall-5a21c-default-rtdb.firebaseio.com/Stores/${store.id}.json';
    print(store.toJson());
    return http
        .patch(url, body: json.encode(store.toJson()))
        .catchError((onError) {
      print(onError.toString());
    }).then((response) {
      print(response.body);
      int updateIndex =
      stores.indexWhere((element) => element.id == store.id);
      stores[updateIndex] = store;
      Fluttertoast.showToast(
          msg: 'Store Updated', backgroundColor: Constants.primaryColor);
      notifyListeners();
    });
  }
}
