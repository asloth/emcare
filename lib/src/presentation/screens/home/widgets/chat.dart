import 'package:emcare/src/domain/auth_service.dart';
import 'package:emcare/src/presentation/components/round_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Chat extends StatelessWidget {
  const Chat({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('Hola aquí estará el chat'),
          Spacer(),
          RoundButton(
            insideText: 'cerrar sesión',
            customFunction: () {
              context.read<AuthService>().signOut();
            },
          )
        ],
      ),
    );
  }
}
