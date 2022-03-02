part of 'register_bloc_bloc.dart';

abstract class RegisterBlocState extends Equatable {
  const RegisterBlocState();
  
  @override
  List<Object> get props => [];
}

class RegisterBlocInitial extends RegisterBlocState {}

class RegisterLoading extends RegisterBlocState {}

class RegisterSuccessState extends RegisterBlocState {
  final RegisterResponse registerResponse;

  const RegisterSuccessState(this.registerResponse);

  @override
  List<Object> get props => [registerResponse];
}

class LoginErrorState extends RegisterBlocState {
  final String message;

  const LoginErrorState(this.message);

  @override
  List<Object> get props => [message];
}