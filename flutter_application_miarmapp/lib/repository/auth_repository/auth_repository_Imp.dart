import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_miarmapp/models/login/login_dto.dart';
import 'package:flutter_application_miarmapp/models/login/login_response.dart';
import 'package:flutter_application_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:http/http.dart';

class AuthRepositoryImpl extends AuthRepository {
  final Client _client = Client();

  @override
  Future<LoginResponse> login(LoginDto loginDto) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map<String, String> headers = {
      'Content-Type': 'application/json', 
    // 'Authorization': 'Bearer $token'
    };

    final response = await _client.post(
        Uri.parse('http://10.0.2.2:8080/auth/login'),
        headers: headers,
        body: jsonEncode(loginDto.toJson()));
    if (response.statusCode == 201) {
      return LoginResponse.fromJson(json.decode(response.body));
    } else {
      throw Exception(prefs.getString('nick').toString());
    }
  }
}