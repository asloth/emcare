import 'package:emcare/constants.dart';
import 'package:emcare/src/presentation/components/input-field.dart';
import 'package:emcare/src/presentation/screens/login/widgets/already_have_an_account_check.dart';
import 'package:emcare/src/presentation/screens/login/widgets/hero.dart';
import 'package:emcare/src/presentation/screens/login/widgets/title.dart';
import 'package:flutter/material.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
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
            title: 'Registrate',
          ),
          InputField(
            hintText: 'Nombre',
          ),
          InputField(
            hintText: 'Correo',
            icon: Icons.email,
          ),
          InputField(
            hintText: 'Contraseña',
            icon: Icons.lock,
            secretField: true,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: 5,
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
                'REGISTRARSE',
                style: TextStyle(
                    // fontSize: size.height * 0.022,
                    ),
              ),
            ),
          ),
          AlreadyHaveAnAccountCheck(
            login: false,
          )
        ],
      ),
    );
  }
}
