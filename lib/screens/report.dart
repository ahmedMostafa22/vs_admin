import 'package:flutter/material.dart';
import 'package:vs_admin/constants.dart';

class Report extends StatefulWidget {
  final String end , start ;

  const Report({Key key, @required this.end,@required this.start}) : super(key: key);
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.secColor,
      appBar: AppBar(title: Text('Report'), centerTitle: true),
      body: Text(widget.start+widget.end),
    );
  }
}
