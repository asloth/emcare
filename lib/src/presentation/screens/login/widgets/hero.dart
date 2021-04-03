import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginHero extends StatelessWidget {
  const LoginHero({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: 20,
      ),
      child: FittedBox(
        child: SvgPicture.asset(
          'assets/imgs/welcome.svg',
        ),
      ),
    );
  }
}
