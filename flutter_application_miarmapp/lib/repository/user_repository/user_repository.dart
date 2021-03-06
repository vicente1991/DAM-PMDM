import 'package:flutter_application_miarmapp/models/user/user_response.dart';

abstract class UserPostRepository {
  Future<UserData> fetchUsers(String type);
}