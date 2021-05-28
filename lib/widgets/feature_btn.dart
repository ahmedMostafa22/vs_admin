import 'package:flutter/material.dart';

import '../constants.dart';

class FeatureButton extends StatelessWidget {
  final Function function;
  final String txt;
  FeatureButton({this.function,this.txt});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: FlatButton(
          highlightColor:Colors.blue,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Constants.borderRadius)),
          padding: EdgeInsets.all(16),
          onPressed: () {
            function();
          },
          color: Constants.primaryColor,
          child: Text(
            txt,
            style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
                fontSize: 12.0,
                fontWeight: FontWeight.bold),
          ),
        ));
  }
}
