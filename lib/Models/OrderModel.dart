class OrderModel {
 late String
      OrderId,
      OrderDate,
      OrderStatus,
      Orderprice,
      CustomerName,
      CutomerContact,
      CustomerAddress,
      ResellerContact,
      ResellerId,

      AmountWholeSeller,
      shopname,
      PickupAddress;

late dynamic orderdetail;
  OrderModel(
      this.OrderId,
      this.OrderDate,
      this.OrderStatus,
      this.Orderprice,
      this.CustomerName,
      this.CutomerContact,
      this.CustomerAddress,
      this.ResellerContact,
      this.ResellerId,
      this.AmountWholeSeller,
      this.shopname,
      this.PickupAddress,
      this.orderdetail
      );
}
