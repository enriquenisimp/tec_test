import 'dart:convert';
import 'package:http/http.dart';
import 'package:tec_test/objects/family.dart';

class Network{

  final String url;
  Network(this.url);

  Future<FamilyList> loadPost() async{
    Response response = await get(Uri.encodeFull(url));

    if(response.statusCode == 200){
      //OK
      //print(response.body[25]);
      return FamilyList.fromJson(json.decode(response.body));
    }else{
      throw Exception("Failed to get posts");
    }
  }
}