import 'package:vs_admin/models/product.dart';

class Report {
  final String startDate, endDate;
   List<Product> products = [] ;
   final double totalPrice ;

  Report({this.startDate, this.endDate, this.products,this.totalPrice});
}
