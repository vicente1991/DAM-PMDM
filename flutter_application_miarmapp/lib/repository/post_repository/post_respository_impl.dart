import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_miarmapp/models/post/post_dto.dart';
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

  @override
  Future<PostResponse> createPublicacion(PostDto dto, String image) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    Map<String, String> pepe = {
      'Authorization': 'Bearer ${prefs.getString('token')}',
      // 'Authorization': 'Bearer $token'
    };

    Map<String, String> headers2 = {
      'Content-Type': 'application/json',
      // 'Authorization': 'Bearer $token'
    };

    var uri = Uri.parse('http://10.0.2.2:8080/post/');
                    var request = http.MultipartRequest('POST', uri);
                    request.fields['titulo'] = prefs.getString('titulo').toString();
                    request.fields['texto'] = prefs.getString('texto').toString();
                    request.fields['estadoPublicacion'] = true.toString();
                    request.files.add(await http.MultipartFile.fromPath('file', prefs.getString('file').toString()));
                    request.headers.addAll(pepe);
                      
                    var response = await request.send();
                    if (response.statusCode == 201) print('Uploaded!');

    if (response.statusCode == 201) {
      return PostResponse.fromJson(
          jsonDecode(await response.stream.bytesToString()));
    } else {
      print(response.statusCode);
      throw Exception(prefs.getString('titulo'));
    }
  }
}
