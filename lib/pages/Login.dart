import 'package:flutter/material.dart';
import './Auth.dart';
import './Latest.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

enum FormType {
  login,
  signup
}

class _LoginState extends State<Login> {

  final formKey = new GlobalKey<FormState>();

  String _name;
  String _email;
  String _password;
  FormType _formType = FormType.login;

  @override
  void initState() {
    super.initState();
  }

  bool isValidated() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      return true;
    } else {
      return false;
    }
  }

  void switchForms() {
    formKey.currentState.reset();
    if (_formType == FormType.login) {
      setState(() {
        _formType = FormType.signup;
      });
    } else {
      setState(() {
        _formType = FormType.login;
      });
    }
  }

  void onLogin() async {
    if (isValidated()) {
      try {
        Auth().signInWithEmailAndPassword(_email, _password).then((user) {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Latest()));
        });
      } catch (error) {
        print("Error: $error");
      }
    } else {
      
    }
  }

    void onSignup() async {
    if (isValidated()) {
      try {
        Auth().createUserWithEmailAndPassword(_name, _email, _password);
      } catch (error) {
        print("Error: $error");
      }
    } else {

    }
  }

  List<Widget> buildInput() {
    if (_formType == FormType.login) {
      return [
        TextFormField(
          validator: (value) => value.isEmpty ? 'Email field empty' : null,
          onSaved: (value) => _email = value,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(
              color: Colors.black
            )
          ),
        ),
        TextFormField(
          validator: (value) => value.isEmpty ? 'Password field empty' : null,
          onSaved: (value) => _password = value,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.black
            )
          ),
          obscureText: true,
        ),
        Padding(
          padding: EdgeInsets.all(12),
        ),
        RaisedButton(
          child: Text('Login', style:TextStyle(
            fontSize: 20,
            color: Colors.white
          )),
          onPressed: () => { onLogin() },
        ),
        FlatButton(
          child: Text('Don\'t have an account? Sign up here.', style: TextStyle(
            fontSize: 12,
            color: Colors.black54
          ),),
          onPressed: () => { switchForms() },
        ),
      ];
    } else {
      return [
        TextFormField(
          validator: (value) => value.isEmpty ? 'Name field empty' : null,
          onSaved: (value) => _name = value,
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: TextStyle(
              color: Colors.black
            )
          ),
        ),
        TextFormField(
          validator: (value) => value.isEmpty ? 'Email field empty' : null,
          onSaved: (value) => _email = value,
          decoration: InputDecoration(
            labelText: 'Email',
            labelStyle: TextStyle(
              color: Colors.black
            )
          ),
        ),
        TextFormField(
          validator: (value) => value.isEmpty ? 'Password field empty' : null,
          onSaved: (value) => _password = value,
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.black
            )
          ),
          obscureText: true,
        ),
        Padding(
          padding: EdgeInsets.all(12),
        ),
        RaisedButton(
          child: Text('Sign up', style:TextStyle(
            fontSize: 20,
            color: Colors.white
          )),
          onPressed: () => { onSignup() },
        ),
        FlatButton(
          child: Text('Already have an account? Login here.', style: TextStyle(
            fontSize: 12,
            color: Colors.black54
          ),),
          onPressed: () => { switchForms() },
        ),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: TextStyle(
          fontWeight: FontWeight.bold,
          letterSpacing: 1.0
        ),),
        elevation: 0.5,
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: buildInput()
          ),
        ),
      )
    );
  }
}
