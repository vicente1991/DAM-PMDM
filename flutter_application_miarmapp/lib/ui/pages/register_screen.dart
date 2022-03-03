import 'dart:io';

import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/bloc/image_pick_bloc/image_pick_bloc_bloc.dart';
import 'package:flutter_application_miarmapp/bloc/register_bloc/register_bloc_bloc.dart';
import 'package:flutter_application_miarmapp/models/register/register_dto.dart';
import 'package:flutter_application_miarmapp/models/register/register_response.dart';
import 'package:flutter_application_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:flutter_application_miarmapp/repository/auth_repository/auth_repository_Imp.dart';
import 'package:flutter_application_miarmapp/ui/pages/menu_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:file_picker/file_picker.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String imageSelect = "Imagen no selecionada";
  FilePickerResult? result;
  PlatformFile? file;
  final _imagePicker = ImagePicker();

  String date = "";
  DateTime selectedDate = DateTime.now();

  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController nombre = TextEditingController();
  TextEditingController apellidos = TextEditingController();
  TextEditingController nick = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController fechaNacimiento = TextEditingController();
  TextEditingController visibilidadUsuario = TextEditingController();
  TextEditingController password2 = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<SharedPreferences> _prefs;
  final String uploadUrl = 'http://10.0.2.2:8080/auth/register';
  String path = "";

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _prefs = SharedPreferences.getInstance();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              return ImagePickBlocBloc();
            },
          ),
          BlocProvider(
            create: (context) {
              return RegisterBlocBloc(authRepository);
            },
          ),
        ],
        child: _createBody(context),
      ),
    );
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<RegisterBlocBloc, RegisterBlocState>(
                listenWhen: (context, state) {
              return state is RegisterSuccessState || state is LoginErrorState;
            }, listener: (context, state) async {
              if (state is RegisterSuccessState) {
                _registerSuccess(context, state.registerResponse);
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is RegisterBlocInitial || state is RegisterLoading;
            }, builder: (ctx, state) {
              if (state is RegisterBlocInitial) {
                return _register(ctx);
              } else if (state is RegisterLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _register(ctx);
              }
            })),
      ),
    );
  }

  Future<void> _registerSuccess(
      BuildContext context, RegisterResponse late) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString('token', late.email);
      prefs.setString('id', late.id);
      prefs.setString('avatar', late.avatar);

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MenuScreen()),
      );
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _register(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Registrate en MiarmApp',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      width: 310,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f5),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: nombre,
                        decoration: const InputDecoration(
                          hintText: 'Nombre',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 310,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xfff1f1f5),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: apellidos,
                          decoration: const InputDecoration(
                            hintText: 'Apellidos',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 310,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xfff1f1f5),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: nick,
                          decoration: const InputDecoration(
                            hintText: 'Nick',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                          width: 310,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xfff1f1f5),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: DateTimeFormField(
                            
                            initialDate: DateTime(2001, 9, 7),
                            firstDate: DateTime.utc(1900),
                            lastDate: DateTime.now(),
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Fecha Nacimiento',
                            ),
                            mode: DateTimeFieldPickerMode.date,
                            autovalidateMode: AutovalidateMode.always,
                            
                            validator: (e) => (e?.day ?? 0) == 1
                                ? 'Please not the first day'
                                : null,
                            onDateSelected: (DateTime value) {
                              selectedDate = value;
                              print(value);
                            },
                          ),
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 310,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xfff1f1f5),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 310,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xfff1f1f5),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: passwordController,
                          decoration: const InputDecoration(
                            hintText: 'Password',
                            suffixIcon: Icon(Icons.remove_red_eye_rounded,
                                color: Colors.black54),
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Container(
                        width: 310,
                        height: 60,
                        decoration: BoxDecoration(
                          color: Color(0xfff1f1f5),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: TextFormField(
                          controller: password2,
                          decoration: const InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    BlocConsumer<ImagePickBlocBloc, ImagePickBlocState>(
                        listenWhen: (context, state) {
                          return state is ImageSelectedSuccessState;
                        },
                        listener: (context, state) {},
                        buildWhen: (context, state) {
                          return state is ImagePickBlocInitial ||
                              state is ImageSelectedSuccessState;
                        },
                        builder: (context, state) {
                          if (state is ImageSelectedSuccessState) {
                            path = state.pickedFile.path;
                            print('PATH ${state.pickedFile.path}');
                            return Column(children: [
                              Image.file(
                                File(state.pickedFile.path),
                                height: 100,
                              ),
                              ElevatedButton(
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('file', path);
                                  },
                                  child: const Text('Upload Image'))
                            ]);
                          }
                          return Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ImagePickBlocBloc>(context)
                                        .add(const SelectImageEvent(
                                            ImageSource.gallery));
                                  },
                                  child: const Text('Select Image')));
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 12,
                  ),
                ],
              ),
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(240, 50), primary: Colors.blue),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    if (_formKey.currentState!.validate()) {
                      final loginDto = RegisterDto(
                          nombre: nombre.text,
                          apellidos: apellidos.text,
                          nick: nick.text,
                          fechaNacimiento: DateFormat("yyyy-MM-dd").format(selectedDate),
                          rol: true,
                          email: emailController.text,
                          password2: password2.text,
                          password: passwordController.text);

                      BlocProvider.of<RegisterBlocBloc>(context)
                          .add(DoRegisterEvent(loginDto, path));
                    }
                    prefs.setString('nombre', nombre.text);
                    prefs.setString('apellidos', apellidos.text);
                    prefs.setString('nick', nick.text);
                    prefs.setString('email', emailController.text);
                    prefs.setString('fechaNacimiento', DateFormat("yyyy-MM-dd").format(selectedDate));
                    prefs.setString('rol', true.toString());
                    prefs.setString('password', passwordController.text);
                    prefs.setString('password2', password2.text);

                    Navigator.pushNamed(context, '/');
                  },
                  child: const Text('Register'),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/');
                      },
                      child: RichText(
                        text: TextSpan(
                          style: DefaultTextStyle.of(context).style,
                          children: const <TextSpan>[
                            TextSpan(
                                text: 'Login',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                    color: Colors.blueAccent)),
                          ],
                        ),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

/*
  Future<String?> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', filepath));
    var res = await request.send();
    return res.reasonPhrase;
  }*/

  
}
