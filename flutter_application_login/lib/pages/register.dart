import 'package:flutter/material.dart';

// Create a Form widget.
class Register extends StatefulWidget {
  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}

// Create a corresponding State class. This class holds data related to the form.
class MyCustomFormState extends State<Register> {
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
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Enter your name',
                labelText: 'Name',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.phone),
                hintText: 'Enter a phone number',
                labelText: 'Phone',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.calendar_today),
                hintText: 'Enter your date of birth',
                labelText: 'Dob',
              ),
            ),
            Container(
                padding: const EdgeInsets.only(left: 150.0, top: 40.0),
                child: const RaisedButton(
                  child: Text('Submit'),
                  onPressed: null,
                )),
          ],
        ),
      ),
    );
  }
}
