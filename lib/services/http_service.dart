import 'dart:convert';

import 'package:http/http.dart';
import 'package:provider_pattern/model/post.dart';
import 'package:provider_pattern/services/logger.service.dart';

class HttpService {
  static String base = "jsonplaceholder.typicode.com";
  static Map<String, String> headers = {
    "Content-type": "application/json; charset=UTF-8"
  };



  /// HTTP REQUESTS
  static Future<String?> GET(String api, Map<String, String> params) async {
    var uri = Uri.https(base, api, params);
    var response = await get(uri, headers: headers);
    LogService.i(response.body);
    if (response.statusCode == 200) {
      return response.body;
    }
    return null;
  }
  static Future<String?> POST(String api, Map<String, String> params) async {
    var uri = Uri.https(base, api);
    var response = await post(uri, headers: headers, body: jsonEncode(params));
    LogService.i(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }
  static Future<String?> PUT(String api, Map<String, String> params) async {
    var uri = Uri.https(base, api);
    var response = await put(uri, headers: headers, body: jsonEncode(params));
    LogService.i(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }
  static Future<String?> DELETE(String api, Map<String, String> params) async {
    var uri = Uri.https(base, api);
    var response = await delete(uri, headers: headers);
    LogService.i(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response.body;
    }
    return null;
  }
  static Map<String,String>paramsEmpty(){
    Map<String,String>params={};
    return params;
  }
  /// HTTP APIS
  static String api_list = "/posts";
  static String API_CREATE = "/posts";
  static String API_UPDATE = "/posts/";
  static String API_DELETE = "posts/";
  static Map<String,String>paramsCreate(Post post){
    Map<String,String>params={};
    params.addAll({
      "title":post.title,
      "body":post.body,
      "userId":post.userId.toString(),
    });
    return params;
  }
  static Map<String,String>updateParams(Post post){
    Map<String,String>params={};
    params.addAll({
      "id":post.id.toString(),
      "title":post.title,
      "body":post.body,
      "userId":post.userId.toString(),
    });
    return params;
  }
  ///*********http parsing
  static List<Post> parseList(String response) {
    var json = jsonDecode(response);
    var data = List<Post>.from(json.map((x) => Post.fromJsom(x)));
    return data;
  }

}
