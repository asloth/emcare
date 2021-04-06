import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
        vertical: 20,
      ),
      child: SvgPicture.asset(
        assetdir,
      ),
    );
  }
}
