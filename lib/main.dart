import 'package:emcare/constants.dart';
import 'package:emcare/src/domain/auth_service.dart';
import 'package:emcare/src/presentation/screens/home/home_screen.dart';
import 'package:emcare/src/presentation/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      // Initialize FlutterFire:
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            title: 'EmCare',
            home: Text('hasError'),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
            title: 'EmCare',
            debugShowCheckedModeBanner: false,
            home: MultiProvider(
              providers: [
                Provider(create: (_) => AuthService(FirebaseAuth.instance)),
                StreamProvider(
                  create: (context) =>
                      context.read<AuthService>().authStateChanges,
                  initialData: null,
                ),
              ],
              child: MaterialApp(
                title: 'EmCare',
                debugShowCheckedModeBanner: false,
                home: AuthenticationWrapper(),
              ),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return Container(
          color: kBackgroundColor,
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null) {
      return Home();
    }
    return LogIn();
  }
}
