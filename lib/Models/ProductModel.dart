class ProductModel{
  late String pname,pimage,

      productDescription,
      shippingfee,
      productColor,
      productSize,
      productprice,
      quantity,
      shopname;
     late int resellerprofit;

  ProductModel(
      this.pname,
      this.pimage,
      this.productDescription,
      this.shippingfee,
      this.productColor,
      this.productSize,
      this.productprice,
      this.quantity,
      this.shopname,
      this.resellerprofit);


  factory ProductModel.fromJson(Map<String, dynamic> json){
    return ProductModel(json['name'], json['imageURL'],json['desc'], json['shippingFee'], json['color'], json['size'], json['unitPrice'], json['qty'], "json['wholeSeller']", json['profit'])
      
      ;
  }
}