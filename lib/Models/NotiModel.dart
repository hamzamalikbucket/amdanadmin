class NotiModel{
  late String title;
  late String body;
  late int order_id;

  NotiModel(this.title, this.body, this.order_id);


  factory NotiModel.fromJson(Map<String, dynamic> json){
    return NotiModel(json['title'], json['body'],json['order_id']);
  }
}