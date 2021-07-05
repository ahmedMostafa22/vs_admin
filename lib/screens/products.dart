import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/constants.dart';
import 'package:vs_admin/view_models/products.dart';
import 'package:vs_admin/view_models/stores.dart';
import 'package:vs_admin/widgets/product_item.dart';

class Products extends StatefulWidget {
  @override
  _ProductsState createState() => _ProductsState();
}

class _ProductsState extends State<Products> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<StoresProvider>(context, listen: false).getStores().then(
            ((val) => Provider.of<ProductsProvider>(context, listen: false)
                .getProducts(context))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secColor,
        appBar: AppBar(title: Text('Products'), centerTitle: true),
        body: Consumer<ProductsProvider>(
            builder: (context, productsProvider, _) => productsProvider
                    .productsLoading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: productsProvider.products.length,
                    itemBuilder: (context, i) =>
                        ProductItem(product: productsProvider.products[i]))));
  }
}
