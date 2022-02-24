import 'package:flutter_application_miarmapp/models/login/login_dto.dart';
import 'package:flutter_application_miarmapp/models/login/login_response.dart';

abstract class AuthRepository {
  Future<LoginResponse> login(LoginDto loginDto);
}