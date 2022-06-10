import 'package:emcare/constants.dart';
import 'package:emcare/src/presentation/components/custom-alert-dialog.dart';
import 'package:emcare/src/presentation/components/input_field.dart';
import 'package:emcare/src/presentation/components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class UpdatePasswordScreen extends StatefulWidget {
  const UpdatePasswordScreen({ Key key }) : super(key: key);

  @override
  State<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends State<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController newPasswordController2 = TextEditingController();
  String message;

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

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

    Future<void> _updating() {
      try {
        firebaseUser.updatePassword(newPasswordController.text);
        _showMyDialog('Actualizacion correcta');
        Navigator.pop(context);
        
      } on FirebaseAuthException catch (e) {
        _showMyDialog(e.message);

      }
    }

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        title: Text("Actualizar clave"),
        backgroundColor: kPrimaryColor,
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InputField(
                hintText: 'Nueva clave',
                icon: Icons.lock ,
                controller: newPasswordController,
                secretField: true,
              ),
              InputField(
                hintText: 'Confirmar nueva clave',
                icon: Icons.lock_reset,
                controller: newPasswordController2,
                secretField: true,
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
                  onPressed: () async => {
                    if (newPasswordController.text != newPasswordController2.text){
                      _showMyDialog('Las claves ingresadas no coninciden'),
                      newPasswordController.clear(),
                      newPasswordController2.clear(),
                    },
                    if (_formKey.currentState.validate()){
                      _updating(),
                    }
                  },
                  child: Text(
                    'CAMBIAR',
                    style: TextStyle(
                        //fontSize: size.height * 0.022,
                        ),
                  ),
                ),
              ),
              RoundButton(
                insideText: 'Cancelar',
                customFunction: (){
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        )
      ),
    );
  }
}