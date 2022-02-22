import 'dart:convert';

import 'package:flutter_application_miarmapp/models/post/post_response.dart';
import 'package:flutter_application_miarmapp/repository/post_repository/post_repository.dart';
import 'package:http/http.dart';

class PostRepositoryImpl extends PostRepository {
  final Client _client = Client();

  /*myModels=(json.decode(response.body) as List).map((i) =>
              MyModel.fromJson(i)).toList();*/

  @override
  Future<List<PostResponse>> fetchPost(String type) async {
    final response = await _client
        .get(Uri.parse('http://10.0.2.2:8080/post/public'), headers: {
      'Authorization':
          'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhYzFiNDYwZC03ZjIxLTFjYjMtODE3Zi0yMTNkMzFiYTAwMDAiLCJpYXQiOjE2NDU2MTY1NDYsIm5vbWJyZSI6IlZpY2VudGUifQ.7wd738QZ_jbyrwaO6hPwLaI-0vQ2ZZRAlgIfsGdBy6c',
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
