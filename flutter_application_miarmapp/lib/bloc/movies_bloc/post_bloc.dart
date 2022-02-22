import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_application_miarmapp/models/post/post_response.dart';
import 'package:flutter_application_miarmapp/repository/post_repository/post_repository.dart';
part 'post_event.dart';
part 'post_state.dart';

class MoviesBloc extends Bloc<PostEvent, PostState> {
  final PostRepository postRepository;

  MoviesBloc(this.postRepository) : super(PostInitial()) {
    on<FetchPostWithType>(_moviesFetched);
  }

  void _moviesFetched(FetchPostWithType event, Emitter<PostState> emit) async {
    try {
      final post = await postRepository.fetchPost(event.type);
      emit(PostFetched(post, event.type));
      return;
    } on Exception catch (e) {
      emit(PostFetchError(e.toString()));
    }
  }
}
