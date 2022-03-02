import 'package:flutter/material.dart';
import 'package:flutter_application_miarmapp/bloc/login_bloc/login_bloc.dart';
import 'package:flutter_application_miarmapp/models/login/login_dto.dart';
import 'package:flutter_application_miarmapp/models/login/login_response.dart';
import 'package:flutter_application_miarmapp/repository/auth_repository/auth_repository.dart';
import 'package:flutter_application_miarmapp/repository/auth_repository/auth_repository_Imp.dart';
import 'package:flutter_application_miarmapp/ui/pages/menu_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthRepository authRepository;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late Future<SharedPreferences> _prefs;

  @override
  void initState() {
    authRepository = AuthRepositoryImpl();
    _prefs = SharedPreferences.getInstance();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) {
          return LoginBloc(authRepository);
        },
        child: _createBody(context));
  }

  _createBody(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Colors.white,
            padding: const EdgeInsets.all(20),
            child: BlocConsumer<LoginBloc, LoginState>(
                listenWhen: (context, state) {
              return state is LoginSuccessState || state is LoginErrorState;
            }, listener: (context, state) async {
              if (state is LoginSuccessState) {
                _loginSuccess(context, state.loginResponse);
              } else if (state is LoginErrorState) {
                _showSnackbar(context, state.message);
              }
            }, buildWhen: (context, state) {
              return state is LoginInitial || state is LoginLoadingState;
            }, builder: (ctx, state) {
              if (state is LoginInitial) {
                return _login(ctx);
              } else if (state is LoginLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else {
                return _login(ctx);
              }
            })),
      ),
    );
  }

  Future<void> _loginSuccess(BuildContext context, LoginResponse late) async {
    _prefs.then((SharedPreferences prefs) {
      prefs.setString('token', late.token);
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

  _login(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Logueate en MiarmApp',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 48,
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
                      validator: (String? value) {
                        return (value == null || !value.contains('@'))
                            ? 'Do not use the @ char.'
                            : null;
                      },
                      onSaved: (String? value) {
                        // This optional block of code can be used to run
                        // code when the user saves the form.
                      },
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
                  SizedBox(
                    height: 32,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xfff1f1f5),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                          ),
                        ),
                        onSaved: (String? value) {
                          // This optional block of code can be used to run
                          // code when the user saves the form.
                        },
                        validator: (value) {
                          return (value == null || value.isEmpty)
                              ? 'Write a password'
                              : null;
                        }),
                  )
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
            const SizedBox(
              height: 32,
            ),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    fixedSize: const Size(240, 50), primary: Colors.blue),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final loginDto = LoginDto(
                        email: emailController.text,
                        password: passwordController.text);
                    BlocProvider.of<LoginBloc>(context)
                        .add(DoLoginEvent(loginDto));
                  }
                },
                child: const Text('Login'),
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 24,
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Don't have an account? ",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/register');
                    },
                    child: RichText(
                      text: TextSpan(
                        style: DefaultTextStyle.of(context).style,
                        children: const <TextSpan>[
                          TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                  color: Colors.blueAccent)),
                        ],
                      ),
                    )),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
