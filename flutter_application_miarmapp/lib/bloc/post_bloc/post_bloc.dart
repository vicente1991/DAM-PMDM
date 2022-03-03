import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_miarmapp/models/post/post_dto.dart';
import 'package:flutter_application_miarmapp/models/post/post_response.dart';
import 'package:flutter_application_miarmapp/repository/post_repository/post_repository.dart';
part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  PostBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPostWithType>(_postFetched);
    on<DoPublicacionEvent>(_doPublicacionEvent);
  }

  void _postFetched(FetchPostWithType event, Emitter<PostState> emit) async {
    try {
      final post = await postRepository.fetchPost(event.type);
      emit(PostFetched(post, event.type));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }

  void _doPublicacionEvent(DoPublicacionEvent event, Emitter<PostState> emit) async {
    try {
      final postResponse = await postRepository.createPublicacion(event.postDto, event.imagePath);
      emit (PublicacionesSuccessState(postResponse));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }
}
