import 'package:emcare/constants.dart';
import 'package:emcare/src/presentation/components/input_field.dart';
import 'package:emcare/src/presentation/screens/login/widgets/already_have_an_account_check.dart';
import 'package:emcare/src/presentation/screens/login/widgets/title.dart';
import 'package:flutter/material.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      padding: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          LoginTitle(
            title: 'Bienvenido',
          ),
          InputField(
            hintText: 'Correo',
            icon: Icons.email,
          ),
          InputField(
            hintText: 'Contraseña',
            secretField: true,
            icon: Icons.lock,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 15,
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: kPrimaryColor,
                shape: StadiumBorder(),
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                ),
              ),
              onPressed: () => {},
              child: Text(
                'INICIAR SESION',
                style: TextStyle(
                  fontSize: size.height * 0.022,
                ),
              ),
            ),
          ),
          AlreadyHaveAnAccountCheck(),
        ],
      ),
    );
  }
}
