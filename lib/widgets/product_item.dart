import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vs_admin/models/product.dart';
import 'package:vs_admin/screens/edit_product.dart';

class ProductItem extends StatelessWidget {
  final Product product;

  const ProductItem({Key key, this.product}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(product.name,style: TextStyle(color:Colors.white),),
            trailing: Container(
              width: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => Get.to(EditProduct(product: product)),
                        child: Icon(Icons.edit,color: Colors.white,)),
                    SizedBox(width: 8)
                  ]),
            ),
          ),
          Divider()
        ],
      ),
    );
  }
}
