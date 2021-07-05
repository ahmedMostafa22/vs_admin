import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vs_admin/models/store.dart';
import 'package:vs_admin/screens/edit_store.dart';

class StoreItem extends StatelessWidget {
  final Store store;

  const StoreItem({Key key, this.store}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(store.name,style: TextStyle(color:Colors.white),),
            trailing: Container(
              width: 100,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                        onTap: () => Get.to(EditStore(store: store)),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.edit,color: Colors.white,),
                        )),
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
