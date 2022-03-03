import 'package:flutter_application_miarmapp/models/post/post_dto.dart';
import 'package:flutter_application_miarmapp/models/post/post_response.dart';

abstract class PostRepository {
  Future<List<PostResponse>> fetchPost(String type);
  Future<PostResponse> createPublicacion(PostDto dto, String image);
}
