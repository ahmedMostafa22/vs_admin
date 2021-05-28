import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vs_admin/screens/orders.dart';
import 'package:vs_admin/screens/products.dart';
import 'package:vs_admin/screens/report.dart';
import 'package:vs_admin/screens/stores.dart';
import 'package:vs_admin/widgets/feature_btn.dart';
import '../constants.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secColor,
        appBar: AppBar(title: Text('Available Features'), centerTitle: true),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GridView(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8),
              children: [
                FeatureButton(
                  txt: 'Orders',
                  function: () => Get.to(Orders()),
                ),
                FeatureButton(
                  txt: 'Products',
                  function: () => Get.to(Products()),
                ),
                FeatureButton(
                  txt: 'Stores',
                  function: () => Get.to(Stores()),
                ),
                FeatureButton(
                  txt: 'Reports',
                  function: () async {
                    String start, end;
                    start = await pickDateBS(context, 'Pick report begin date');
                    if(start!=null)
                    end = await pickDateBS(context, 'Pick report end date');
                    if(start!=null&&end!=null)
                    Get.to(Report(start: start , end: end));
                    },
                ),
                FeatureButton(
                    txt: 'Sign out',
                    function: () => FirebaseAuth.instance.signOut())
              ]),
        ));
  }

  Future<String> pickDateBS(BuildContext context, String title) async {
    String currentDate;
    return showCupertinoModalPopup<String>(
        context: context,
        builder: (context) => Container(
              margin: EdgeInsets.only(bottom: Get.height * .15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(Constants.borderRadius)),
              child: SizedBox(
                height: Get.height * 0.5,
                width: Get.width * 0.8,
                child: Material(
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(Constants.borderRadius)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Constants.primaryColor),
                      ),
                      Container(
                        height: 70,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          minimumDate: DateTime.now(),
                          initialDateTime: DateTime.now(),
                          onDateTimeChanged: (DateTime value) {
                            currentDate = value.toString();
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context).pop(currentDate ?? DateTime.now().toString());
                        },
                        child: Container(
                          width: Get.width * .2,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(Constants.borderRadius)),
                              color: Constants.primaryColor),
                          padding:
                              EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: Center(
                            child: Text(
                              'Confirm',
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
