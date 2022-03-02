part of 'register_bloc_bloc.dart';

abstract class RegisterBlocEvent extends Equatable {
  const RegisterBlocEvent();

  @override
  List<Object> get props => [];
}

class DoRegisterEvent extends RegisterBlocEvent {
  final RegisterDto registerDto;
  final String imagePath;

  const DoRegisterEvent(this.registerDto, this.imagePath);
}
