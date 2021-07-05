import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Product {
  final String dbId, storeId;
  String discription, name, sprite, colors, size;
  final int id;
  int quantity, price;

  Product(
      {this.colors,
      this.size,
      this.dbId,
      this.storeId,
      this.discription,
      this.name,
      this.sprite,
      this.id,
      this.quantity,
      this.price});

  Product.fromJson(Map<String, dynamic> json)
      : colors = json['colors'],
        size = json['size'],
        dbId = json['dbId'],
        storeId = json['storeId'],
        discription = json['discription'],
        name = json['name'],
        sprite = json['sprite'],
        id = json['id'],
        quantity = json['quantity'],
        price = json['price'];

  Map<String, dynamic> toJson() => {
        'colors': colors,
        'size': size,
        'dbId': dbId,
        'storeId': storeId,
        'discription': discription,
        'name': name,
        'sprite': sprite,
        'id': id,
        'quantity': quantity,
        'price': price
      };
}
