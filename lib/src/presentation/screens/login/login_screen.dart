import 'package:emcare/constants.dart';
import 'package:emcare/src/presentation/screens/login/widgets/body.dart';
import 'package:flutter/material.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: LoginBody(),
    );
  }
}
