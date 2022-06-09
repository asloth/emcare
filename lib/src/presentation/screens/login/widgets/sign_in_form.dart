import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/auth_service.dart';
import 'package:emcare/src/presentation/components/custom-alert-dialog.dart';
import 'package:emcare/src/presentation/components/input_field.dart';
import 'package:emcare/src/presentation/screens/login/widgets/already_have_an_account_check.dart';
import 'package:emcare/src/presentation/screens/login/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    Key key,
  }) : super(key: key);

  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    Future<void> _showMyDialog(String aviso) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return CustomAlertDialog(
            aviso: aviso,
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
              title: 'Bienvenido',
            ),
            InputField(
              hintText: 'Correo',
              icon: Icons.email,
              controller: emailController,
            ),
            InputField(
              hintText: 'Contraseña',
              secretField: true,
              icon: Icons.lock,
              controller: passwordController,
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
                onPressed: () => {
                  if (_formKey.currentState.validate())
                    {
                      context
                          .read<AuthService>()
                          .signIn(
                            email: emailController.text.trim(),
                            password: passwordController.text.trim(),
                          )
                          .then((value) => {
                                if (value != 'Signed in') {_showMyDialog(value)}
                              })
                    }
                },
                child: Text(
                  'INICIAR SESION',
                  style: TextStyle(
                      //fontSize: size.height * 0.022,
                      ),
                ),
              ),
            ),
            AlreadyHaveAnAccountCheck(),
          ],
        ),
      ),
    );
  }
}
