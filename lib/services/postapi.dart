import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:tugas_ui/models/post.dart';

class PostAPI{
  static Future<List<Post>> getPosts() async {
  var url = Uri.parse("https://jsonplaceholder.typicode.com/albums/1/photos");
  final response = 
    await http.get(url, headers: {"Content-Type": "application/json"});
  final List body = json.decode(response.body);
  return body.map((e) => Post.fromJson(e)).toList();
}
}