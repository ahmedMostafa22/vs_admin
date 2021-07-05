import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:vs_admin/models/product.dart';
import 'package:vs_admin/view_models/products.dart';
import 'package:vs_admin/widgets/app_raised_btn.dart';
import '../constants.dart';

class EditProduct extends StatefulWidget {
  final Product product;
  const EditProduct({this.product});
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<EditProduct> {
  List<String> colors = [], sizes = [];

  final _priceFocusNode = FocusNode();
  final _descriptionFocusNode = FocusNode();
  final _qtyFocusNode = FocusNode();
  bool btnEnabled = false;

  var _controllerTitle = TextEditingController();
  var _controllerPrice = TextEditingController();
  var _controllerDescription = TextEditingController();
  var _controllerQty = TextEditingController();

  var _addColor = TextEditingController();
  var _addSize = TextEditingController();

  bool loadingVisable = false;
  final _form = new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    _controllerQty.text = widget.product.quantity.toString();
    _controllerTitle.text = widget.product.name;
    _controllerPrice.text = widget.product.price.toString();
    _controllerDescription.text = widget.product.discription;

    colors = Constants.extractData(widget.product.colors);
    sizes = Constants.extractData(widget.product.size);

    btnEnabled = true;
  }

  @override
  void dispose() {
    _priceFocusNode.dispose();
    _descriptionFocusNode.dispose();
    _qtyFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: true,
        resizeToAvoidBottomPadding: true,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _form,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: _controllerTitle,
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
                      decoration: InputDecoration(
                          labelText: 'Price',
                          labelStyle: TextStyle(color: Colors.white70),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70))),
                      cursorColor: Colors.white70,
                      style: TextStyle(color: Colors.white70),
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
                      decoration: InputDecoration(
                          labelText: 'Description',
                          labelStyle: TextStyle(color: Colors.white70),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70))),
                      cursorColor: Colors.white70,
                      style: TextStyle(color: Colors.white70),
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
                      decoration: InputDecoration(
                          labelText: 'Quantity',
                          labelStyle: TextStyle(color: Colors.white70),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70)),
                          border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white70))),
                      cursorColor: Colors.white70,
                      style: TextStyle(color: Colors.white70),
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      focusNode: _qtyFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
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
                  //////////////////////////////////

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Sizes',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                title: 'Add Size',
                                titleStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                    fontSize: 18),
                                backgroundColor: Constants.secColor,
                                content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _addSize,
                                          decoration: InputDecoration(
                                              labelText: 'Size',
                                              labelStyle: TextStyle(
                                                  color: Colors.white70),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .white70)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .white70)),
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.white70))),
                                          cursorColor: Colors.white70,
                                          style: TextStyle(
                                              color: Colors.white70),
                                          textInputAction:
                                              TextInputAction.done,
                                        ),
                                      ),
                                      AppRaisedButton(
                                        txt: 'Add',
                                        function: () {
                                          if (_addSize.text.isNotEmpty) {
                                            setState(() => sizes
                                                .add(_addSize.text.trim()));
                                            _addSize.clear();
                                            _saveForm();
                                          }
                                          Get.back();
                                        },
                                      )
                                    ]));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: Get.width * .9,
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) => Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              children: [
                                Text(
                                  sizes[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 4),
                                InkWell(
                                  onTap: () {
                                    setState(() => sizes.removeAt(i));
                                    _saveForm();
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                        itemCount: sizes.length,
                      ),
                    ),
                  ),

                  //////////////////////////////////
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Text(
                          'Colors',
                          style: TextStyle(color: Colors.white70),
                        ),
                        SizedBox(width: 8),
                        InkWell(
                          onTap: () {
                            Get.defaultDialog(
                                title: 'Add Color',
                                titleStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white70,
                                    fontSize: 18),
                                backgroundColor: Constants.secColor,
                                content: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: TextFormField(
                                          controller: _addColor,
                                          decoration: InputDecoration(
                                              labelText: 'Color',
                                              labelStyle: TextStyle(
                                                  color: Colors.white70),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .white70)),
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors
                                                              .white70)),
                                              border: UnderlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color:
                                                          Colors.white70))),
                                          cursorColor: Colors.white70,
                                          style: TextStyle(
                                              color: Colors.white70),
                                          textInputAction:
                                              TextInputAction.done,
                                        ),
                                      ),
                                      AppRaisedButton(
                                        txt: 'Add',
                                        function: () {
                                          if (_addColor.text.isNotEmpty) {
                                            setState(() => colors
                                                .add(_addColor.text.trim()));
                                            _addColor.clear();
                                            _saveForm();
                                          }
                                          Get.back();
                                        },
                                      )
                                    ]));
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.add, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: Get.width * .9,
                      height: 50,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, i) => Container(
                            padding: EdgeInsets.all(8),
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: Constants.primaryColor,
                                borderRadius: BorderRadius.circular(50)),
                            child: Row(
                              children: [
                                Text(
                                  colors[i],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(width: 4),
                                InkWell(
                                  onTap: () {
                                    setState(() => colors.removeAt(i));
                                    _saveForm();
                                  },
                                  child: Icon(
                                    Icons.clear,
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            )),
                        itemCount: colors.length,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Center(
                    child: loadingVisable
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
                                        try {
                                          String colorsString = '';
                                          for (int i = 0;
                                              i < colors.length;
                                              i++)
                                            colorsString += colors[i] +
                                                (colors.length == i + 1
                                                    ? ''
                                                    : '*');

                                          String sizesString = '';
                                          for (int i = 0;
                                              i < sizes.length;
                                              i++)
                                            sizesString += sizes[i] +
                                                (sizes.length == i + 1
                                                    ? ''
                                                    : '*');

                                          await Provider.of<ProductsProvider>(
                                                  context,
                                                  listen: false)
                                              .updateProduct(Product(
                                                  colors: colorsString,
                                                  size: sizesString,
                                                  id: widget.product.id,
                                                  storeId:
                                                      widget.product.storeId,
                                                  dbId: widget.product.dbId,
                                                  discription:
                                                      _controllerDescription
                                                          .text,
                                                  name: _controllerTitle.text,
                                                  sprite:
                                                      widget.product.sprite,
                                                  quantity: int.parse(
                                                      _controllerQty.text),
                                                  price: int.parse(
                                                      _controllerPrice
                                                          .text)));
                                          Get.back();
                                        } catch (onError) {
                                          setState(
                                              () => loadingVisable = false);
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        'An error occured'),
                                                    content: Text(
                                                        onError.toString()),
                                                    actions: <Widget>[
                                                      FlatButton(
                                                          onPressed: () {
                                                            Get.back();
                                                          },
                                                          child:
                                                              Text('Dismiss'))
                                                    ],
                                                  ));
                                        }
                                      },
                                color: Constants.primaryColor,
                                child: Text('Save',
                                    style: TextStyle(color: Colors.white))),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
        backgroundColor: Constants.secColor,
        appBar: AppBar(title: Text('Edit Product'), centerTitle: true));
  }

  void _saveForm() {
    if (_form.currentState.validate() &&
        colors.isNotEmpty &&
        sizes.isNotEmpty) {
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
