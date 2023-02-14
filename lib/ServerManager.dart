import 'dart:convert';

import 'package:http/http.dart';

class ServerManager{

  String baseurl='https://api-stg.amdan.pk/api/v1/';


  Future<dynamic> login(String email, String password) async{
    Map map = Map();
    map['email'] = email;
    map['password'] = password;
    print(map);
    var url = Uri.parse(baseurl+'admin/login');
    Response res = await post(url, body: map);
    if (res.statusCode == 200) {
      dynamic body = jsonDecode(res.body);
      return body;
    } else {
      print(Error);
      throw new Exception("Error");
    }
  }


}