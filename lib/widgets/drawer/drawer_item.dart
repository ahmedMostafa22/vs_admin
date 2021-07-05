import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final String text;
  final function;

  const DrawerListTile({Key key, this.text, this.function})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap:()=> function(),
        child: ListTile(
            title: Text(text,
                style: TextStyle(
                    color: Colors.white70,
                    fontWeight: FontWeight.bold,
                    fontSize: 18))));
  }
}
