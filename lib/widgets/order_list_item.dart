import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/constants.dart';
import 'package:vs_admin/models/order.dart';
import 'package:vs_admin/models/user.dart';
import 'package:vs_admin/view_models/orders.dart';

import 'bill_item.dart';

class OrderListItem extends StatefulWidget {
  final Order order;
  const OrderListItem({Key key, this.order}) : super(key: key);

  @override
  _OrderListItemState createState() => _OrderListItemState();
}

class _OrderListItemState extends State<OrderListItem> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius)),
          elevation: 5,
          color: Constants.secColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text("Total : " + widget.order.totalCost.toString(),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white70,
                          fontSize: 20)),
                  Text("Order Date : " + widget.order.time,
                      style: TextStyle(color: Colors.white70)),
                  SizedBox(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(Constants.borderRadius)),
                        onPressed: () {
                          showOrderItems(context);
                        },
                        child: Text(
                          'Order Details',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      loading
                          ? Center(child: CircularProgressIndicator())
                          : RaisedButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                      Constants.borderRadius)),
                              onPressed: () async {
                                setState(() => loading = true);
                                StoreUser user =
                                    await Provider.of<OrdersProvider>(context,
                                            listen: false)
                                        .getOrderCustomer(widget.order.uId);
                                setState(() => loading = false);
                                showCustomerDetails(context, user);
                              },
                              child: Text(
                                'Customer Details',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                    ],
                  ),
                ]),
          )),
    );
  }

  void showOrderItems(var context) {
    showModalBottomSheet(
        context: context,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius)),
        isScrollControlled: true,
        builder: (context) => SingleChildScrollView(
                child: Container(
              decoration: BoxDecoration(
                  color: Constants.secColor,
                  borderRadius: BorderRadius.circular(Constants.borderRadius)),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.6,
              child: ListView.builder(
                  itemCount: widget.order.items.length,
                  itemBuilder: (context, i) =>
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: BillItem(item: widget.order.items[i]),
                      )),
            )));
  }

  void showCustomerDetails(var context, StoreUser user) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Constants.borderRadius)),
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              decoration: BoxDecoration(
                  color: Constants.secColor,
                  borderRadius: BorderRadius.circular(Constants.borderRadius)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  user.email,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white70),
                ),
              ),
            ));
  }
}
