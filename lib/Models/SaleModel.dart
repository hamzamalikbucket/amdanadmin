import 'package:amdanadmin/Models/SaleModel.dart';

class SaleModel {
  SaleModel(this.date, this.sales);
  late List<dynamic> list;

  final String date;
  final double sales;

   //factory SaleModel.fromjson(this.list);
  factory SaleModel.fromJson(Map<dynamic, dynamic> json){
    return SaleModel(json['date'], json['orders']);
  }


 /* factory SaleModel.withProduct(Map<String, dynamic> json){
    SaleModel b = new SaleModel.api(json['date'],json['orders']);
    print(json['ordersByDay'].length);
    dynamic products = json['ordersByDay'];
    for(int i=0;i<products.length; i++){
      dynamic item = products[i];
      b.productList.add(Product.fromJson(item));
    }
    return b;
  }*/
}