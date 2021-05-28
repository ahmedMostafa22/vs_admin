import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Product {
  final String dbId, storeId;
  String discription, name, sprite, colors, size;
  final int id;
  int quantity;
  int price;

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

   Product.fromJson(Map<String, dynamic> json) :
      colors= json['colors'],
      size= json['size'],
      dbId= json['dbId'],
      storeId= json['storeId'],
      discription= json['discription'],
      name= json['name'],
      sprite= json['sprite'],
      id= json['id'],
      quantity= json['quantity'],
      price= json['price'];

  Map<String, dynamic> toJson() => {
        'colors': this.colors,
        'size': this.size,
        'dbId': this.dbId,
        'storeId': this.storeId,
        'discription': this.discription,
        'name': this.name,
        'sprite': this.sprite,
        'id': this.id,
        'quantity': this.quantity,
        'price': this.price
      };
}
