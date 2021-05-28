import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../constants.dart';

class AppRaisedButton extends StatefulWidget {
  final Function function;
  final String txt;
  const AppRaisedButton({Key key, this.function, this.txt}) : super(key: key);
  @override
  _AppRaisedButtonState createState() => _AppRaisedButtonState();
}

class _AppRaisedButtonState extends State<AppRaisedButton> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.symmetric(vertical: 16.0),
        child: FractionallySizedBox(
          widthFactor: .7,
          child: CupertinoButton(
            borderRadius: BorderRadius.circular(Constants.borderRadius),
            padding: EdgeInsets.all(16),
            onPressed: () async {
              setState(() => loading = true);
              await widget.function();
              setState(() => loading = false);
            },
            color: Constants.primaryColor,
            child: Text(
              widget.txt,
              style: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1,
                  fontSize: 12.0,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }
}
