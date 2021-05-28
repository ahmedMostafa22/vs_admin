import 'package:vs_admin/models/product.dart';

class Order {
  final List<Product> items;
  final String id, storeId, time, uId;
  final int totalCost;

  Order(
      {this.items, this.id, this.storeId, this.time, this.uId, this.totalCost});
}
