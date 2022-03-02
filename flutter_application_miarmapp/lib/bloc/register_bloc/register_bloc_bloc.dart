import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_application_miarmapp/models/register/register_dto.dart';
import 'package:flutter_application_miarmapp/models/register/register_response.dart';
import 'package:flutter_application_miarmapp/repository/auth_repository/auth_repository.dart';

part 'register_bloc_event.dart';
part 'register_bloc_state.dart';

class RegisterBlocBloc extends Bloc<RegisterBlocEvent, RegisterBlocState> {
  final AuthRepository authRepository;
  RegisterBlocBloc(this.authRepository) : super(RegisterBlocInitial()) {
    on<DoRegisterEvent>(_doRegisterEvent);
  }

  void _doRegisterEvent(DoRegisterEvent event, Emitter<RegisterBlocState> emit) async {
    try {
      final registerResponse = await authRepository.register(event.registerDto, event.imagePath);
      emit(RegisterSuccessState(registerResponse));
      return;
    } on Exception catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
