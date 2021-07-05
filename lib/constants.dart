import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class Constants {
  static const primaryColor = Color(0xFF6379CD);
  static const secColor = Color(0xFF585858);
  static const double borderRadius = 25.0;

  static showToast(String msg, bool isError) {
    Fluttertoast.showToast(
        msg: msg, backgroundColor: isError ? Colors.red : Colors.green);
  }

  static Future<String> pickDateBS(BuildContext context, String title) async {
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
                          mode: CupertinoDatePickerMode.date,
                          maximumDate: DateTime.now(),
                          initialDateTime:
                              DateTime.now().subtract(Duration(hours: 1)),
                          onDateTimeChanged: (DateTime value) {
                            currentDate = value.toString();
                          },
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.of(context)
                              .pop(currentDate ?? DateTime.now().toString());
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

  static List<String> extractData(String encodedString) {
    List<String> result = [];
    String current = '';
    for (int i = 0; i < encodedString.length; i++) {
      if (encodedString[i] == "*" || i == encodedString.length - 1) {
        if (i == encodedString.length - 1) current += encodedString[i];
        result.add(current);
        current = '';
      } else
        current += encodedString[i];
    }
    return result;
  }
}
