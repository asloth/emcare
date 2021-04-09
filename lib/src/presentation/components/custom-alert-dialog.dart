import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String aviso;
  const CustomAlertDialog({
    Key key,
    @required this.aviso,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
  }
}
