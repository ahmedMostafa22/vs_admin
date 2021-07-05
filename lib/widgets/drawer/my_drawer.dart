import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:vs_admin/screens/report.dart';
import 'package:vs_admin/screens/products.dart';
import 'package:vs_admin/screens/stores.dart';
import 'package:vs_admin/widgets/drawer/drawer_item.dart';
import '../../constants.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Constants.secColor,
        width: Get.width * .7,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical:16.0,horizontal: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                      backgroundImage: AssetImage('images/appicon.jpg'),
                      radius: Get.width * .1),SizedBox(width: 8),
                  Text(
                    FirebaseAuth.instance.currentUser.email,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  )
                ],
              ),
            ),
            Divider(),
            DrawerListTile(
              text: 'Products',
              function: () => Get.to(Products()),
            ),
            DrawerListTile(
              text: 'Stores',
              function: () => Get.to(Stores()),
            ),
            DrawerListTile(
              text: 'Reports',
              function: () async {
                String start, end;
                start = await Constants.pickDateBS(
                    context, 'Pick report begin date');
                if (start != null)
                  end = await Constants.pickDateBS(
                      context, 'Pick report end date');
                if (start != null &&
                    end != null &&
                    !start.compareTo(end).isGreaterThan(0))
                  Get.to(Report(start: start, end: end));
                else
                  Fluttertoast.showToast(msg: 'incorrect!');
              },
            ),
            DrawerListTile(
                text: 'Sign out',
                function: () => FirebaseAuth.instance.signOut())
          ],
        ),
      ),
    );
  }
}
