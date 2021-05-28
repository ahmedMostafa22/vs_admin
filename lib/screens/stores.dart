import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/constants.dart';
import 'package:vs_admin/view_models/stores.dart';
import 'package:vs_admin/widgets/store_item.dart';

class Stores extends StatefulWidget {
  @override
  _StoresState createState() => _StoresState();
}

class _StoresState extends State<Stores> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<StoresProvider>(context, listen: false).getStores());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secColor,
        appBar: AppBar(title: Text('Stores'), centerTitle: true),
        body: Consumer<StoresProvider>(
            builder: (context, storesProvider, _) => storesProvider
                .loadingStores
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                itemCount: storesProvider.stores.length,
                itemBuilder: (context, i) =>
                    StoreItem(store: storesProvider.stores[i]))));
  }
}
