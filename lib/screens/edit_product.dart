import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/models/product.dart';
import '../constants.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  const EditProduct({this.product});
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _qtyFocusNode = FocusNode();
  final _sizesFocusNode = FocusNode();
  final _colorsFocusNode = FocusNode();
  bool btnEnabled = false;

  var _controllerTitle = TextEditingController();
  var _controllerPrice = TextEditingController();
  var _controllerDescription = TextEditingController();
  var _controllerQty = TextEditingController();
  var _controllerSizes = TextEditingController();
  var _controllerColors = TextEditingController();

  bool loadingVisable = false;
  final _form = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _controllerQty.text = widget.product.quantity.toString();
    _controllerTitle.text = widget.product.name;
    _controllerPrice.text = widget.product.price.toString();
    _controllerDescription.text = widget.product.discription;
    _controllerSizes.text = widget.product.size;
    _controllerColors.text = widget.product.colors;
    btnEnabled = true;
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _qtyFocusNode.dispose();
    _sizesFocusNode.dispose();
    _colorsFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerTitle,
                    decoration: InputDecoration(labelText: 'Name',   labelStyle: TextStyle(color: Colors.white70  ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  ))),
                    cursorColor: Colors.white70 ,
                    style: TextStyle(color: Colors.white70  ),
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      _saveForm();
                      FocusScope.of(context).requestFocus(_priceFocusNode);
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
                    controller: _controllerPrice,
                    decoration: InputDecoration(labelText: 'Price',   labelStyle: TextStyle(color: Colors.white70 ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  ))),
                      cursorColor: Colors.white70 ,
                      style: TextStyle(color: Colors.white70  ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _priceFocusNode,
                    onFieldSubmitted: (_) {
                      _saveForm();
                      FocusScope.of(context)
                          .requestFocus(_descriptionFocusNode);
                    },
                    onChanged: (val) {
                      _saveForm();
                    },
                    validator: (val) {
                      if (val.isEmpty ||
                          double.tryParse(val) == null ||
                          double.parse(val) < 0.0)
                        return "Field content is not valid";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerDescription,
                    decoration: InputDecoration(labelText: 'Description',   labelStyle: TextStyle(color: Colors.white70 ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  ))),
                    cursorColor: Colors.white70 ,
                    style: TextStyle(color: Colors.white70  ),
                    maxLines: 3,
                    focusNode: _descriptionFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      _saveForm();
                      FocusScope.of(context).requestFocus(_qtyFocusNode);
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
                    controller: _controllerQty,
                    decoration: InputDecoration(labelText: 'Quantity',   labelStyle: TextStyle(color: Colors.white70  ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  ))),
                    cursorColor: Colors.white70 ,
                    style: TextStyle(color: Colors.white70  ),
                    keyboardType: TextInputType.number,
                    textInputAction: TextInputAction.next,
                    focusNode: _qtyFocusNode,
                    onFieldSubmitted: (_) {
                      _saveForm();
                      FocusScope.of(context).requestFocus(_sizesFocusNode);
                    },
                    onChanged: (val) {
                      _saveForm();
                    },
                    validator: (val) {
                      if (val.isEmpty ||
                          double.tryParse(val) == null ||
                          double.parse(val) < 0.0)
                        return "Field content is not valid";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerSizes,
                    decoration: InputDecoration(labelText: 'Sizes',   labelStyle: TextStyle(color: Colors.white70 ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  ))),
                    cursorColor: Colors.white70 ,
                    style: TextStyle(color: Colors.white70  ),
                    focusNode: _sizesFocusNode,
                    textInputAction: TextInputAction.next,
                    onFieldSubmitted: (_) {
                      _saveForm();
                      FocusScope.of(context).requestFocus(_colorsFocusNode);
                    },
                    onChanged: (val) {
                      _saveForm();
                    },
                    validator: (val) {
                      if (val.isEmpty) return "Field content is not valid";
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: _controllerColors,
                    decoration: InputDecoration(labelText: 'Colors',   labelStyle: TextStyle(color: Colors.white70  ),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  )),
                        border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70  ))),
                      cursorColor: Colors.white70 ,
                      style: TextStyle(color: Colors.white70  ),
                    focusNode: _colorsFocusNode,
                    onFieldSubmitted: (_) {
                      _saveForm();
                    },
                    onChanged: (val) {
                      _saveForm();
                    },
                    validator: (val) {
                      if (val.isEmpty) return "Field content is not valid";
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 32),
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
                                      Navigator.pop(context);
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
        backgroundColor: Constants.secColor,
        appBar: AppBar(title: Text('Edit Product'), centerTitle: true));
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

class CCB extends StatefulWidget {
  final Function function;
  final String title;
  final bool initalState;

  const CCB({Key key, this.function, this.title, this.initalState})
      : super(key: key);
  @override
  _CCBState createState() => _CCBState();
}

class _CCBState extends State<CCB> {
  bool value;
  @override
  void initState() {
    super.initState();
    value = widget.initalState;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: <Widget>[
      Checkbox(
        checkColor: Colors.black,
        activeColor: Constants.primaryColor,
        onChanged: (val) {
          setState(() {
            widget.function();
            value = val;
          });
        },
        value: value,
      ),
      Text(widget.title)
    ]);
  }
}
