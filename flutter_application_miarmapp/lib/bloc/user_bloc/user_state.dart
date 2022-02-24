part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();
  
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UsersFetched extends UserState {
  final UserData users;
  final String type;

  const UsersFetched(this.users, this.type);

  @override
  List<Object> get props => [users];
}

class UserFetchedError extends UserState {
  final String message;
  const UserFetchedError(this.message);

  @override
  List<Object> get props => [message];
}
