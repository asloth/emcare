import 'package:emcare/src/presentation/screens/login/widgets/hero.dart';
import 'package:emcare/src/presentation/screens/login/widgets/sign_in_form.dart';
import 'package:emcare/src/presentation/screens/login/widgets/sign_up_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: PageView(
        children: [
          SignInBody(),
          SignUpBody(),
        ],
      ),
    );
  }
}

class SignInBody extends StatelessWidget {
  const SignInBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      child: orientation == Orientation.portrait
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginHero(
                    assetdir: 'assets/imgs/welcome.svg',
                  ),
                  SignInForm(),
                ],
              ),
            )
          : Row(
              children: [
                LoginHero(
                  assetdir: 'assets/imgs/welcome.svg',
                ),
                SignInForm(),
              ],
            ),
    );
  }
}

class SignUpBody extends StatelessWidget {
  const SignUpBody({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      child: orientation == Orientation.portrait
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/imgs/note_taking_isometric.svg',
                    ),
                  ),
                  SignUpForm(),
                ],
              ),
            )
          : Row(
              children: [Text('Aqui para registrarte en horizontal reina')],
            ),
    );
  }
}
