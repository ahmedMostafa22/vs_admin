import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/constants.dart';
import 'package:vs_admin/view_models/orders.dart';
import 'package:vs_admin/view_models/stores.dart';
import 'package:vs_admin/widgets/bill_item.dart';

class Report extends StatefulWidget {
  final String end, start;

  const Report({Key key, @required this.end, @required this.start})
      : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero).then((value) =>
        Provider.of<StoresProvider>(context, listen: false).getStores().then(
            (value) => Provider.of<OrdersProvider>(context, listen: false)
                .getReport(context, widget.start.substring(0, 10),
                    widget.end.substring(0, 10))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secColor,
      appBar: AppBar(title: Text('Report'), centerTitle: true),
      body: Consumer<OrdersProvider>(
          builder: (context, orderProvider, _) => orderProvider.report ==
                      null ||
                  orderProvider.report.products.isEmpty ||
                  orderProvider.ordersLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Text(
                        'Total Profit : ' +
                            orderProvider.report.totalPrice.round().toString() +
                            ' EGP',
                        style: TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: orderProvider.report.products.length,
                          itemBuilder: (context, i) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: BillItem(
                                    item: orderProvider.report.products[i]),
                              )),
                    ),
                  ],
                )),
    );
  }
}
