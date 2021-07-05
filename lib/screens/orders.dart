import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/constants.dart';
import 'package:vs_admin/view_models/orders.dart';
import 'package:vs_admin/view_models/stores.dart';
import 'package:vs_admin/widgets/drawer/my_drawer.dart';
import 'package:vs_admin/widgets/order_list_item.dart';

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<StoresProvider>(context, listen: false).getStores().then(
            (value) => Provider.of<OrdersProvider>(context, listen: false)
                .getOrders(context)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secColor,
      appBar: AppBar(title: Text('Orders'), centerTitle: true),
      drawer: MyDrawer(),
      body: Consumer<OrdersProvider>(
          builder: (context, ordersProvider, _) => ordersProvider.ordersLoading
              ? Center(child: CircularProgressIndicator())
              : RefreshIndicator(
                  onRefresh: () async =>
                      Provider.of<OrdersProvider>(context, listen: false)
                          .getOrders(context),
                  child: ListView.builder(
                      itemCount: ordersProvider.orders.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, i) => OrderListItem(
                          order: ordersProvider
                              .orders[ordersProvider.orders.length - 1 - i])),
                )),
    );
  }
}
