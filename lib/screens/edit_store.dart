import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/models/store.dart';
import 'package:vs_admin/view_models/stores.dart';
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
  final _addressFN = FocusNode();
  final _categFN = FocusNode();

  bool btnEnabled = false;
  var _controllerAddress = TextEditingController();
  var _controllerPhone = TextEditingController();
  var _controllerWebsite = TextEditingController();
  var _controllerName = TextEditingController();
  var _controllerCategory = TextEditingController();

  bool loadingVisable = false;
  final _form = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    _controllerName.text = widget.store.name;
    _controllerAddress.text = widget.store.address;
    _controllerPhone.text = widget.store.phoneNum;
    _controllerWebsite.text = widget.store.website;
    _controllerCategory.text = widget.store.category;

    btnEnabled = true;
  }

  @override
  void dispose() {
    _phoneFocusNode.dispose();
    _websiteFocusNode.dispose();
    _addressFN.dispose();
    _categFN.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Constants.secColor,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerName,
                    decoration: InputDecoration(
                        labelText: 'Name',
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
                      FocusScope.of(context).requestFocus(_addressFN);
                    },
                    onChanged: (val) {
                      _saveForm();
                    },
                    validator: (val) {
                      if (val.isEmpty) return "Field can't be empty";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
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
                    focusNode: _addressFN,
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
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
                      FocusScope.of(context).requestFocus(_categFN);
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
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerCategory,
                    decoration: InputDecoration(
                        labelText: 'Category',
                        labelStyle: TextStyle(color: Colors.white70),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70))),
                    cursorColor: Colors.white70,
                    style: TextStyle(color: Colors.white70),
                    focusNode: _categFN,
                    textInputAction: TextInputAction.done,
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
                                    setState(() => loadingVisable = true);
                                    _saveForm();
                                    try {
                                      await Provider.of<StoresProvider>(context,
                                              listen: false)
                                          .updateStore(Store(
                                              name: _controllerName.text,
                                              id: widget.store.id,
                                              ownerId: FirebaseAuth
                                                  .instance.currentUser.uid,
                                              address: _controllerAddress.text,
                                              category: _controllerCategory.text,
                                              phoneNum: _controllerPhone.text,
                                              website: _controllerWebsite.text,
                                              productsCount:
                                                  widget.store.productsCount,
                                              index: widget.store.index,
                                              level: widget.store.level));
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
