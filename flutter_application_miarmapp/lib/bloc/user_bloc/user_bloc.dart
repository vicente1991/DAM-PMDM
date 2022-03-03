import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_miarmapp/models/user/user_response.dart';
import 'package:flutter_application_miarmapp/repository/user_repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserWithPostBloc extends Bloc<UserEvent, UserState> {
    final UserPostRepository public;

  UserWithPostBloc(this.public) : super(UserInitial()) {
    on<FetchUserWithType>(_publicacionesFetched);
}

void _publicacionesFetched(FetchUserWithType event, Emitter<UserState> emit) async {
    try {
      final movies = await public.fetchUsers(event.type);
      emit(UsersFetched(movies, event.type));
      return;
    } on Exception catch (e) {
      emit(UserFetchedError(e.toString()));
    }
  }
}


