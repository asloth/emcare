import 'package:emcare/constants.dart';
import 'package:emcare/src/presentation/screens/login/widgets/hero.dart';
import 'package:flutter/material.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHero(),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: Text(
                'Bienvenido',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: size.height * 0.05,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                vertical: 30,
                horizontal: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: kPrimaryColor,
                      shape: StadiumBorder(),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                      ),
                    ),
                    onPressed: () => {},
                    child: Text(
                      'INICIAR SESION CON GOOGLE',
                      style: TextStyle(
                        fontSize: size.height * 0.022,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
