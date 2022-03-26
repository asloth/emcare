import 'package:flutter/material.dart';

class LoginHero extends StatelessWidget {
  final String assetdir;
  const LoginHero({
    Key key,
    @required this.assetdir,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 10,
      ),
      child: Image(
        image: AssetImage(assetdir),
      ),
    );
  }
}
