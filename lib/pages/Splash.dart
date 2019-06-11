import 'package:flutter/material.dart';
import './Auth.dart';
import './Login.dart';
import './Latest.dart';

class Splash extends StatefulWidget {
  @override
  SplashState createState() => SplashState();
}

class SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();

    isUserLoggedIn();
  }

  isUserLoggedIn() async {

    var user = await Auth().currentUser();

    if (user != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Latest()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.purpleAccent,
              Colors.redAccent
            ],
            begin: Alignment(0.2, 0),
            end: Alignment(-0.2, -1)
          )
        ),
      )
    );
  }
}
