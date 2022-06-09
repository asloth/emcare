import 'package:emcare/src/presentation/components/round_button.dart';
import 'package:flutter/material.dart';

class UpdateNameForm extends StatelessWidget {
  const UpdateNameForm({ Key key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RoundButton(
          insideText: 'Regresar',
          customFunction: (){
            Navigator.pop(context);
          },
          
        ),
      ),
    );
  }
}