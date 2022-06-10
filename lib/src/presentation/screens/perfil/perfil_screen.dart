import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/auth_service.dart';
import 'package:emcare/src/domain/user.dart';
import 'package:emcare/src/presentation/components/round_button.dart';
import 'package:emcare/src/presentation/screens/perfil/components/perfil_input.dart';
import 'package:emcare/src/presentation/screens/perfil/components/update-name.dart';
import 'package:emcare/src/presentation/screens/perfil/components/update-password.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Perfil extends StatefulWidget {
  const Perfil({ Key key }) : super(key: key);

  @override
  State<Perfil> createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    final fontS = 25.0;
    String userName;
    MyUser currentUserData = new MyUser();
    Future<Map> userData = (currentUserData.getUser(firebaseUser.uid));
      userData.then((value) {
        userName = value['name'];
      });
    
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                child: Text('Perfil',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: fontS,
                  ),
                ),
              ),
              FutureBuilder(
                future: userData,
                builder: (context, snapshot){
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error.toString()}');
                  }
      
                  if (snapshot.connectionState == ConnectionState.done){
                    return PerfilInput(
                      text: userName,
                    );
                  }
                  
      
                  return Container(
                    color: kBackgroundColor,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                },
              ),
              PerfilInput(
                text: firebaseUser.email,
                icon: Icons.email,
              ),
              RoundButton(
                insideText: 'Cambiar nombre',
                customFunction: (){
                  Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => UpdateNameForm()),
                  ).then((value) => value? setState((){
                    userData = (currentUserData.getUser(firebaseUser.uid));
                  }):null ) ;
                },
              ),
              RoundButton(
                insideText: 'Cambiar contraseña',
                customFunction: (){
                  Navigator.of(context).push(
                    new MaterialPageRoute(builder: (_) => UpdatePasswordScreen()),
                  );
                },
              ),
              RoundButton(
                insideText: 'Cerrar Sesión', 
                customFunction: () {
                  context.read<AuthService>().signOut();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}