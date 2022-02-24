import 'dart:convert';

import 'package:flutter_application_miarmapp/models/post/post_response.dart';
import 'package:flutter_application_miarmapp/repository/post_repository/post_repository.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  /*myModels=(json.decode(response.body) as List).map((i) =>
              MyModel.fromJson(i)).toList();*/

  @override
  Future<List<PostResponse>> fetchPost(String type) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final response = await _client
        .get(Uri.parse('http://10.0.2.2:8080/post/public'), headers: {
      'Authorization':
          'Bearer ${prefs.getString('token')}',
    });
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((i) => PostResponse.fromJson(i))
          .toList();
    } else {
      throw Exception('Fail to load post');
    }
  }
}
