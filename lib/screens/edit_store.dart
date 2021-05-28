import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/models/store.dart';
import '../constants.dart';

class EditStore extends StatefulWidget {
  final Store store;
  const EditStore({this.store});
  @override
  _EditStoreState createState() => _EditStoreState();
}

class _EditStoreState extends State<EditStore> {
  final _phoneFocusNode = FocusNode();
  final _websiteFocusNode = FocusNode();
  bool btnEnabled = false;
  var _controllerAddress = TextEditingController();
  var _controllerPhone = TextEditingController();
  var _controllerWebsite = TextEditingController();
  bool loadingVisable = false;
  final _form = new GlobalKey<FormState>();
  String categ;
  @override
  void initState() {
    super.initState();
    categ = 'Accessories';
    _controllerAddress.text = widget.store.address;
    _controllerPhone.text = widget.store.phoneNum.toString();
    _controllerWebsite.text = widget.store.website;
    btnEnabled = true;
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _websiteFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secColor,
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                TextFormField(
                  controller: _controllerAddress,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      labelStyle: TextStyle(color: Colors.white70),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70))),
                  cursorColor: Colors.white70,
                  style: TextStyle(color: Colors.white70),
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    _saveForm();
                    FocusScope.of(context).requestFocus(_phoneFocusNode);
                  },
                  onChanged: (val) {
                    _saveForm();
                  },
                  validator: (val) {
                    if (val.isEmpty) return "Field can't be empty";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerPhone,
                  decoration: InputDecoration(
                      labelText: 'Phone Number',
                      labelStyle: TextStyle(color: Colors.white70),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70))),
                  cursorColor: Colors.white70,
                  style: TextStyle(color: Colors.white70),
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  focusNode: _phoneFocusNode,
                  onFieldSubmitted: (_) {
                    _saveForm();
                    FocusScope.of(context).requestFocus(_websiteFocusNode);
                  },
                  onChanged: (val) {
                    _saveForm();
                  },
                  validator: (val) {
                    if (val.isEmpty ||
                        val.length != 11 ||
                        val.substring(0, 2) != '01')
                      return "Field content is not valid";
                    return null;
                  },
                ),
                TextFormField(
                  controller: _controllerWebsite,
                  decoration: InputDecoration(
                      labelText: 'Website',
                      labelStyle: TextStyle(color: Colors.white70),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70)),
                      border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white70))),
                  cursorColor: Colors.white70,
                  style: TextStyle(color: Colors.white70),
                  focusNode: _websiteFocusNode,
                  textInputAction: TextInputAction.next,
                  onFieldSubmitted: (_) {
                    _saveForm();
                  },
                  onChanged: (val) {
                    _saveForm();
                  },
                  validator: (val) {
                    if (val.isEmpty) return "Field can't be empty";
                    return null;
                  },
                ),
                Center(
                  child: DropdownButton<String>(
                      dropdownColor: Constants.secColor,
                      iconEnabledColor: Colors.white70,
                      underline: SizedBox(),
                      value: categ,
                      hint: Text(categ, style: TextStyle(color: Colors.white70)),
                      onChanged: (String newValue) {
                        _saveForm();
                        setState(() {
                          categ = newValue;
                        });
                      },
                      items: <String>[
                        'Accessories',
                        'Pants',
                        'Dresses',
                        'Skirts',
                        'Sportswear',
                        'Shoes',
                        'T-Shirts',
                        'Shirts',
                        'Shorts',
                        'Underwear',
                        'Jeans',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                                style: TextStyle(color: Colors.white70)));
                      }).toList()),
                ),
                SizedBox(height: 20),
                loadingVisable
                    ? LinearProgressIndicator()
                    : FractionallySizedBox(
                        widthFactor: .7,
                        child: RaisedButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    Constants.borderRadius)),
                            onPressed: !btnEnabled
                                ? null
                                : () async {
                                    setState(() {
                                      loadingVisable = true;
                                      btnEnabled = false;
                                    });
                                    _saveForm();
                                    try {
                                      Get.back();
                                    } catch (onError) {
                                      showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                                title: Text('An error occured'),
                                                content: Text(
                                                    'Something went wrong !'),
                                                actions: <Widget>[
                                                  FlatButton(
                                                      onPressed: () {
                                                        Get.back();
                                                      },
                                                      child: Text('Dismiss'))
                                                ],
                                              ));
                                      Get.back();
                                    }
                                  },
                            color: Constants.primaryColor,
                            child: Text('Save',
                                style: TextStyle(color: Colors.white))),
                      ),
              ],
            ),
          ),
        ),
        appBar: AppBar(title: Text('Edit Store'), centerTitle: true));
  }

  void _saveForm() {
    if (_form.currentState.validate()) {
      _form.currentState.save();
      setState(() {
        btnEnabled = true;
      });
    } else {
      setState(() {
        btnEnabled = false;
      });
    }
  }
}
