import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/models/product.dart';
import 'package:vs_admin/view_models/products.dart';

class BillItem extends StatefulWidget {
  final Product item;
  const BillItem({@required this.item});

  @override
  _BillItemState createState() => _BillItemState();
}

class _BillItemState extends State<BillItem> {
  Product product;
  var future;
  @override
  void initState() {
    super.initState();
    future = Provider.of<ProductsProvider>(context, listen: false)
        .getProductData(widget.item.dbId)
        .then((value) => product = value);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (c, s) {
          if (s.connectionState == ConnectionState.waiting)
            return Center(child: CircularProgressIndicator());
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(product.name.trim() ?? "NA",
                          style:
                              TextStyle(color: Colors.white70, fontSize: 16)),
                      SizedBox(height: 8),
                      Text(
                        "Price " + product.price.toString() ?? "NA" + " EGP",
                        style: TextStyle(color: Colors.white70, fontSize: 16),
                      ),
                      SizedBox(height: 8),
                      Text('Qty : ' + widget.item.quantity.toString(),
                          style:
                              TextStyle(color: Colors.white70, fontSize: 16)),
                      SizedBox(height: 8),
                      Text(
                          'Total : ' +
                              (product.price * widget.item.quantity).toString(),
                          style:
                              TextStyle(color: Colors.white70, fontSize: 16)),
                    ]),
              ),
              Divider()
            ],
          );
        });
  }
}
