import 'dart:convert';

import 'package:flutter_application_miarmapp/models/post/post_response.dart';
import 'package:flutter_application_miarmapp/models/user/user_response.dart';
import 'package:flutter_application_miarmapp/repository/user_repository/user_repository.dart';
import 'package:http/http.dart';

class UserPostRepositoryImpl extends UserPostRepository {
  final Client _client = Client();

/*List<PublicacionData> myModels;
var response = await http.get("myUrl");
myModels=(json.decode(response.body) as List).map((i) =>
              MyModel.fromJson(i)).toList();*/

  @override
  Future<UserData> fetchUsers(String type) async {
    final response = await _client.get(
        Uri.parse(
            'http://10.0.2.2:8080/me'),
        headers: {
          'Authorization':
              'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiJhYzFiNDYwZC03ZjJiLTFjZDQtODE3Zi0yYjFkNTJkYjAwMDAiLCJpYXQiOjE2NDU3ODIyMTgsIm5vbWJyZSI6IlZpY2VudGUifQ.AebDFBFNUGN6A8PzBsPj0NjNZ3nzsWodrajmYlOLhxs'
        });
    if (response.statusCode == 200) {
      return UserData.fromJson(json.decode(response.body));
    } else {
      throw Exception('Fail to load users');
    }
  }
}
