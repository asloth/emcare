import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/auth_service.dart';
import 'package:emcare/src/presentation/components/input_field.dart';
import 'package:emcare/src/presentation/screens/login/widgets/already_have_an_account_check.dart';
import 'package:emcare/src/presentation/screens/login/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignUpForm extends StatefulWidget {
  SignUpForm({Key key}) : super(key: key);

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;

    Future<void> _showMyDialog(String aviso) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Información'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(aviso),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Entendido'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return Form(
      key: _formKey,
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
              controller: newNameController,
            ),
            InputField(
              hintText: 'Correo',
              icon: Icons.email,
              controller: newEmailController,
            ),
            InputField(
              hintText: 'Contraseña',
              controller: newPasswordController,
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
                onPressed: () => {
                  if (_formKey.currentState.validate())
                    {
                      context
                          .read<AuthService>()
                          .signUp(
                            email: newEmailController.text.trim(),
                            password: newPasswordController.text.trim(),
                          )
                          .then((value) => {
                                if (value != 'Signed up') {_showMyDialog(value)}
                              })
                    }
                },
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
      ),
    );
  }
}
