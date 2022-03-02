import 'dart:io';

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
import 'package:shared_preferences/shared_preferences.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({ Key? key }) : super(key: key);

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
  TextEditingController rol = TextEditingController();
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
                    'Register your account',
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
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: nombre,
                        decoration: InputDecoration(
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
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: apellidos,
                        decoration: InputDecoration(
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
                    SizedBox(
                      height: 32,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 230,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            controller: nick,
                            decoration: InputDecoration(
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
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                          width: 110,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              _selectDate(context);
                            },
                            child: Row(
                              children: [
                                Icon(Icons.calendar_today_outlined),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 32,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(14.0),
                      ),
                      child: TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
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
                    SizedBox(
                      height: 32,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 165,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            controller: passwordController,
                            decoration: InputDecoration(
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
                        SizedBox(
                          width: 18,
                        ),
                        Container(
                          width: 165,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(14.0),
                          ),
                          child: TextFormField(
                            controller: password2,
                            decoration: InputDecoration(
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
                      ],
                    ),
                    SizedBox(
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
                                    // TODO el evento que debeis crear en el BLoC para
                                    // poder subir la imagen que tenemos guardada en
                                    // state.pickedFile.path

                                    var res = await uploadImage(
                                        state.pickedFile.path, uploadUrl);
                                    print(state.pickedFile.path);

                                    /*var request = http.MultipartRequest(
                                        "POST",
                                        Uri.parse(
                                            'http://10.0.2.2:8080/auth/register'));
                                    var picture = http.MultipartFile.fromBytes(
                                        'file',
                                        (await rootBundle
                                                .load(state.pickedFile.path))
                                            .buffer
                                            .asUint8List(),
                                        filename: state.pickedFile.toString());
                                    request.files.add(picture);
                                    var response = await request.send();
                                    var responseData =
                                        await response.stream.toBytes();
                                    var result =
                                        String.fromCharCodes(responseData);
                                    print(result);*/
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
                     if (_formKey.currentState!.validate()) {
                final loginDto = RegisterDto(
                  nombre: nombre.text,
                  apellidos: apellidos.text,
                  nick: nick.text,
                  fechaNacimiento: '2001-04-08',
                  rol: true,
                    email: emailController.text,
                    password2: password2.text,
                    password: passwordController.text);

                BlocProvider.of<RegisterBlocBloc>(context).add(DoRegisterEvent(loginDto, path));
              }
              

                    /*var uri = Uri.parse('http://10.0.2.2:8080/auth/register');
                    var request = http.MultipartRequest('POST', uri);
                    request.fields['user[nombre]'] = nombre.text;
                    request.fields['user[apellidos]'] = apellidos.text;
                    request.fields['user[nick]'] = nick.text;
                    request.fields['user[email]'] = emailController.text;
                    request.fields['user[fechaNacimiento]'] = selectedDate.toString();
                    request.fields['user[rol]'] = true.toString();
                    request.fields['user[password]'] = passwordController.text;
                    request.fields['user[password2]'] = password2.text;
                      
                    var response = await request.send();
                    if (response.statusCode == 201) print('Uploaded!');*/

                    Navigator.pushNamed(context, '/menu');
                  },
                  child: const Text('Register'),
                ),
              ),
              SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(
  fontSize: 16,
  fontWeight: FontWeight.w400,
),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> uploadImage(filepath, url) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));
    request.files.add(await http.MultipartFile.fromPath('file', filepath));
    var res = await request.send();
    return res.reasonPhrase;
  }

  Future<DateTime?> showDatePicker({
    required BuildContext context,
    required DateTime initialDate,
    required DateTime firstDate,
    required DateTime lastDate,
    DateTime? currentDate,
    DatePickerEntryMode initialEntryMode = DatePickerEntryMode.calendar,
    SelectableDayPredicate? selectableDayPredicate,
    String? helpText,
    String? cancelText,
    String? confirmText,
    Locale? locale,
    bool useRootNavigator = true,
    RouteSettings? routeSettings,
    TextDirection? textDirection,
    TransitionBuilder? builder,
    DatePickerMode initialDatePickerMode = DatePickerMode.day,
    String? errorFormatText,
    String? errorInvalidText,
    String? fieldHintText,
    String? fieldLabelText,
  }) async {
    Widget dialog = DatePickerDialog(
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
      currentDate: currentDate,
      initialEntryMode: initialEntryMode,
      selectableDayPredicate: selectableDayPredicate,
      helpText: helpText,
      cancelText: cancelText,
      confirmText: confirmText,
      initialCalendarMode: initialDatePickerMode,
      errorFormatText: errorFormatText,
      errorInvalidText: errorInvalidText,
      fieldHintText: fieldHintText,
      fieldLabelText: fieldLabelText,
    );

    if (textDirection != null) {
      dialog = Directionality(
        textDirection: textDirection,
        child: dialog,
      );
    }

    if (locale != null) {
      dialog = Localizations.override(
        context: context,
        locale: locale,
        child: dialog,
      );
    }

    return showDialog<DateTime>(
      context: context,
      useRootNavigator: useRootNavigator,
      routeSettings: routeSettings,
      builder: (BuildContext context) {
        return builder == null ? dialog : builder(context, dialog);
      },
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: selectedDate,
    );

    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
  }

  pickFiles(String filetype) async {
    if (filetype == "Image") {
      imageSelect = "Imagen Seleccionada";
      result = await FilePicker.platform.pickFiles(type: FileType.image);

      imageSelect = result!.files.first.name;
    }

    if (filetype == "Video") {
      result = await FilePicker.platform.pickFiles(type: FileType.video);

      file = result!.files.first;
    }
  }
}