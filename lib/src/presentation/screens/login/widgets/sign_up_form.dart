import 'package:emcare/src/presentation/components/input-field.dart';
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
    return Expanded(
      child: Container(
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
          ],
        ),
      ),
    );
  }
}
