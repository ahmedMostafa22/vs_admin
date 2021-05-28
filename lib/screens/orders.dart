import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/constants.dart';
import 'package:vs_admin/view_models/orders.dart';
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
        Provider.of<OrdersProvider>(context, listen: false).getOrders());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secColor,
      appBar: AppBar(title: Text('Orders'), centerTitle: true),
      body: Consumer<OrdersProvider>(
          builder: (context, ordersProvider, _) => ordersProvider.ordersLoading
              ? Center(child: CircularProgressIndicator())
              : ListView.builder(
                  itemCount: ordersProvider.orders.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context, i) =>
                      OrderListItem(order: ordersProvider.orders[ordersProvider.orders.length-1-i]))),
    );
  }
}
