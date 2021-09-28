import 'package:flutter/material.dart';
import 'desktop_mode.dart';
import 'mobile_mode.dart';

class RegisterPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth <= 720) {
          return MobileMode();
        } else {
          return DesktopMode();
        }
      },
    );
  }
}
