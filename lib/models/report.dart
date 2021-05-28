import 'package:vs_admin/models/product.dart';

class Report {
  final String startDate, endDate;
  final List<Product> products;

  Report({this.startDate, this.endDate, this.products});
}
