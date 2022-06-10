import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/user.dart';
import 'package:emcare/src/presentation/components/custom-alert-dialog.dart';
import 'package:emcare/src/presentation/components/input_field.dart';
import 'package:emcare/src/presentation/components/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UpdateNameForm extends StatefulWidget {
  const UpdateNameForm({ Key key }) : super(key: key);

  @override
  State<UpdateNameForm> createState() => _UpdateNameFormState();
}

class _UpdateNameFormState extends State<UpdateNameForm> {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController newNameController = TextEditingController();
    
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
    
    return Scaffold(
      appBar: AppBar(
        title: Text("Actualizar nombre"),
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
                hintText: 'Ingrese el nuevo nombre',
                icon: Icons.person,
                controller: newNameController,
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
                    if (_formKey.currentState.validate())
                      {
                        message =await  MyUser.updateUserName(firebaseUser.uid, newNameController.text),
                        _showMyDialog(message),
                        if (message == 'Actualizado correctamente'){
                          newNameController.text = '',
                          Navigator.pop(context, true)
                        }

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
                  Navigator.pop(context, false);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}