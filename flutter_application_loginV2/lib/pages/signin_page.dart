import 'package:flutter/material.dart';

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(20),
                  child: const Text(
                    'Hello Again!',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(0.0),
                  child: Column(
                    children: [
                      RichText(
                        text: const TextSpan(
                          text: 'Welcome back \n',
                          style: TextStyle(fontSize: 20, color: Colors.grey),
                          children: <TextSpan>[
                            TextSpan(
                                text: '        been missed',
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.grey,
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(20),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Email',
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                  child: TextField(
                    obscureText: true,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                    ),
                  ),
                ),
              ],
            ),
            TextButton(
              onPressed: () {
                //forgot password screen
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                    text: const TextSpan(
                        text: 'Recovery Password \n',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.grey,
                        )),
                  ),
                ],
              ),
            ),
            Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextButton(
                  child: const Text('Sign In',
                      style: TextStyle(color: Colors.black)),
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.redAccent[100]),
                  onPressed: () {
                    print(emailController.text);
                    print(passwordController.text);
                  },
                )),
            Row(
              children: <Widget>[
                const Text('Not a member?'),
                TextButton(
                  child: const Text(
                    'Register now',
                    style: TextStyle(fontSize: 12),
                  ),
                  onPressed: () {
                    //signup screen
                  },
                )
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            Column(
              children: [
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(5),
                    margin: const EdgeInsets.all(20),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Color(0x55FFFFFF),
                                Color(0xFF0000000),
                              ])),
                            )),
                        const Expanded(
                          flex: 2,
                          child: Text(
                            '            Or continue',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.w500,
                                fontSize: 15),
                          ),
                        ),
                        Expanded(
                            flex: 1,
                            child: Container(
                              height: 2,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(colors: [
                                Color(0xFF0000000),
                                Color(0xFFFFFFFF)
                              ])),
                            )),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.network(
                      'https://cdn-icons-png.flaticon.com/512/2991/2991148.png',
                      width: 50,
                    ),
                    Image.network(
                      'https://cdn3.iconfinder.com/data/icons/picons-social/57/56-apple-512.png',
                      width: 70,
                    ),
                    Image.network(
                      'https://cdn3.iconfinder.com/data/icons/capsocial-round/500/facebook-512.png',
                      width: 50,
                    )
                  ],
                )
              ],
            )
          ],
        ));
  }
}