import 'package:flutter/material.dart';
import 'ui/weatherpage.dart';

import './ui/login.dart';

void main() {
  runApp(MaterialApp(
    home: Splash(),
    routes: {
      'Login': (BuildContext context) => new Login(),
    },
    title: "Weatherist",
  ));
}

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {
      Navigator.popAndPushNamed(context, 'Login');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlutterLogo(
          size: 400,
        ),
      ),
    );
  }
}
