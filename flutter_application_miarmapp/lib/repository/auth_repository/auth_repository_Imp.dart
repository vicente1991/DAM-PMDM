import 'dart:convert';
import 'package:flutter_application_miarmapp/models/register/register_dto.dart';
import 'package:http/http.dart';
import 'package:flutter_application_miarmapp/models/register/register_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_miarmapp/models/login/login_dto.dart';
import 'package:flutter_application_miarmapp/models/login/login_response.dart';
import 'package:flutter_application_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:http/http.dart' as http;

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

  @override
  Future<RegisterResponse> register(
      RegisterDto registerDto, String imagePath) async {
    /*final response = await _client.post(
        Uri.parse('http://10.0.2.2:8080/auth/register/user'),
        headers: headers,
        body: jsonEncode(registerDto.toJson()));*/

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://10.0.2.2:8080/auth/register/user'))
      ..fields['user'] = jsonEncode(registerDto.toJson())..headers
      ..files.add(await http.MultipartFile.fromPath('file', imagePath));
    final response = await request.send();

    if (response.statusCode == 201) {
      return RegisterResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      throw Exception('Failed to register');
    }
  }
}