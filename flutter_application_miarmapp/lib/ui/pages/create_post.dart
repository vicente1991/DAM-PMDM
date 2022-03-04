import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/bloc/image_pick_bloc/image_pick_bloc_bloc.dart';
import 'package:flutter_application_miarmapp/bloc/post_bloc/post_bloc.dart';
import 'package:flutter_application_miarmapp/models/post/post_dto.dart';
import 'package:flutter_application_miarmapp/models/post/post_response.dart';
import 'package:flutter_application_miarmapp/repository/post_repository/post_repository.dart';
import 'package:flutter_application_miarmapp/repository/post_repository/post_respository_impl.dart';
import 'package:flutter_application_miarmapp/ui/pages/home_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toggle_switch/toggle_switch.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  String imageSelect = "Imagen no selecionada";
  FilePickerResult? result;
  PlatformFile? file;
  final _imagePicker = ImagePicker();

  String date = "";
  DateTime selectedDate = DateTime.now();

  late PostRepository _publicacionRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController titulo = TextEditingController();
  TextEditingController texto = TextEditingController();
  TextEditingController estadoPublicacion = TextEditingController();
  late Future<SharedPreferences> _prefs;
  final String uploadUrl = 'http://10.0.2.2:8080/auth/register';
  String path = "";
  bool _passwordVisible = false;
  bool _password2Visible = false;
  bool isPublic = true;

  @override
  void initState() {
    _publicacionRepository = PostRepositoryImpl();
    _prefs = SharedPreferences.getInstance();
    _passwordVisible = false;
    _password2Visible = false;
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
              return PostBloc(_publicacionRepository);
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
            child:
                BlocConsumer<PostBloc, PostState>(listenWhen: (context, state) {
              return state is PublicacionesSuccessState ||
                  state is PostFetchError;
            }, listener: (context, state) async {
              if (state is PublicacionesSuccessState) {
                _loginSuccess(context, state.postResponse);
              } else if (state is PostFetchError) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is BlocPublicacionesInitial ||
                  state is PublicacionesLoading;
            }, builder: (ctx, state) {
              if (state is BlocPublicacionesInitial) {
                return _post(ctx);
              } else if (state is PublicacionesLoading) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _post(ctx);
              }
            })),
      ),
    );
  }

  Future<void> _loginSuccess(BuildContext context, PostResponse late) async {
    _prefs.then((SharedPreferences prefs) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  _post(BuildContext context) {
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
                    'Create Publication',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 24,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f5),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: titulo,
                        decoration: const InputDecoration(
                          hintText: 'Titulo',
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
                    SizedBox(
                      height: 24,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color(0xfff1f1f5),
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: texto,
                        decoration: const InputDecoration(
                          hintText: 'Texto',
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
                    SizedBox(
                      height: 24,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 310,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Color(0xfff1f1f5),
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: Column(
                            children: [
                              Container(
                                width: 310,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Color(0xfff1f1f5),
                                  borderRadius: BorderRadius.circular(14.0),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: const [
                                        Text(
                                          "Tipo de publicación: ",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black45),
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: ToggleSwitch(
                                        cornerRadius: 20.0,
                                        activeBgColors: [
                                          [Colors.green[800]!],
                                          [Colors.red[800]!]
                                        ],
                                        activeFgColor: Colors.white,
                                        inactiveBgColor: Colors.grey,
                                        inactiveFgColor: Colors.white,
                                        initialLabelIndex: 0,
                                        totalSwitches: 2,
                                        labels: ['Publico', 'Privada'],
                                        radiusStyle: true,
                                        onToggle: (index) {
                                          index == 0
                                              ? isPublic = true
                                              : isPublic = false;
                                          print('switched to: $isPublic');
                                        },
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
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
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                  ),
                                  onPressed: () async {
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setString('file', path);
                                  },
                                  child: const Text('Cargar Imagen'))
                            ]);
                          }
                          return Center(
                              child: ElevatedButton(
                                  onPressed: () {
                                    BlocProvider.of<ImagePickBlocBloc>(context)
                                        .add(const SelectImageEvent(
                                            ImageSource.gallery));
                                  },
                                  child: const Text('Seleccionar Imagen')));
                        })
                  ],
                ),
              ),
              SizedBox(
                height: 32,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: const [
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
                      final loginDto = PostDto(
                          titulo: titulo.text,
                          texto: texto.text,
                          estadoPublicacion: true);
                      BlocProvider.of<PostBloc>(context)
                          .add(DoPublicacionEvent(loginDto, path));
                    }
                    prefs.setString('titulo', titulo.text);
                    prefs.setString('texto', texto.text);
                    prefs.setString('estadoPublicacion', true.toString());
                  },
                  child: const Text('Create New'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
