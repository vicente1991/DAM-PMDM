import 'package:flutter/material.dart';

// Create a Form widget.
class Login extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<Login> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(40),
                child: const Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
            ),
           Container(
                  margin: const EdgeInsets.all(10),
                  child: const TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(Icons.password),
                      labelText: 'Password',
                    ),
                  ),
                ),
            Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: const RaisedButton(
                  child: Text('Submit'),
                  onPressed: null,
                )),
            Container(
              padding: const EdgeInsets.only(left: 150.0, top: 20.0),
              child: ElevatedButton(
                child: const Text('Ir a registro'),
                onPressed: () {
                  Navigator.pushNamed(context, '/register');
                },
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
        ),
      ),
    );
  }
}
