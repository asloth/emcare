import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/auth_service.dart';
import 'package:emcare/src/presentation/components/custom-alert-dialog.dart';
import 'package:emcare/src/presentation/components/input_field.dart';
import 'package:emcare/src/presentation/screens/login/widgets/already_have_an_account_check.dart';
import 'package:emcare/src/presentation/screens/login/widgets/title.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

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
  bool isCompromiseChecked = false;
  bool isPrivacyPolicyChecked = false;

  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;

    void _launchUserCompromise() async {
      const url = 'https://emcare-expressjs-api.herokuapp.com/user-compromise';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    void _launchPrivacyPolicy() async {
      const url = 'https://emcare-expressjs-api.herokuapp.com/privacy-policy';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

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
              title: 'Regístrate',
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
            FittedBox(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: kPrimaryColor,
                    value: isCompromiseChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isCompromiseChecked = value;
                      });
                    },
                  ),
                  Text('He leído y estoy acuerdo con'),
                  TextButton(
                    onPressed: _launchUserCompromise,
                    child: Text('Compromiso de usuario'),
                  ),
                ],
              ),
            ),
            FittedBox(
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: kPrimaryColor,
                    value: isPrivacyPolicyChecked,
                    onChanged: (bool value) {
                      setState(() {
                        isPrivacyPolicyChecked = value;
                      });
                    },
                  ),
                  Text('He leído y estoy acuerdo con'),
                  TextButton(
                    onPressed: _launchPrivacyPolicy,
                    child: Text('Política de privacidad de datos'),
                  ),
                ],
              ),
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
                  if (isCompromiseChecked && isPrivacyPolicyChecked)
                    {
                      if (_formKey.currentState.validate())
                        {
                          context
                              .read<AuthService>()
                              .signUp(
                                email: newEmailController.text.trim(),
                                password: newPasswordController.text.trim(),
                                username: newNameController.text.trim(),
                              )
                              .then((value) => {
                                    if (value != 'Signed up')
                                      {_showMyDialog(value)}
                                  })
                        }
                    }
                  else
                    {
                      _showMyDialog(
                          'Por favor lea y acepte el Compromiso de usuario y las Políticas de privacidad para poder registrarse')
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
