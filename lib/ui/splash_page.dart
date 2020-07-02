import 'dart:async';

import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    performDelay();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.lime,
        child: Center(
          child: Text('Splash Page'),
        ),
      ),
    );
  }

  performDelay() async {
    var _duration = new Duration(seconds: 1);
    return new Timer(_duration, () {
      Navigator.pushReplacementNamed(
        context,
        '/main',
      );
    });
  }
}
