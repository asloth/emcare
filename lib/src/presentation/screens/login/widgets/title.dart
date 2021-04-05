import 'package:flutter/material.dart';

class LoginTitle extends StatelessWidget {
  final String title;
  const LoginTitle({
    Key key,
    @required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 10,
      ),
      child: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: size.height * 0.05,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
