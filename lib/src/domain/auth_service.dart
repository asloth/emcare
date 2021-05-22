import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;

class AuthService {
  final FirebaseAuth _auth;

  AuthService(
    this._auth,
  );

  Stream<User> get authStateChanges {
    return _auth.authStateChanges();
  }

  Future<String> signIn({
    String email,
    String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return 'Signed in';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'wrong-password') {
        return 'Contraseña errónea';
      } else if (e.code == 'invalid-email') {
        return 'Correo no válido';
      } else if (e.code == 'user-not-found') {
        return 'Usuario no encontrado, si no tiene una cuenta por favor regístrese';
      } else {
        return 'ninguna opcion gilasa';
      }
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<String> signUp({
    String email,
    String password,
    String username,
  }) async {
    try {
      await _auth
          .createUserWithEmailAndPassword(
            email: email,
            password: password,
          )
          .then((value) => {
                _setUser(value.user.uid, username),
              });

      return 'Signed up';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'La contraseña ingresada es muy débil';
      } else if (e.code == 'email-already-in-use') {
        return 'El correo ingresado ya está en uso';
      }
    } catch (e) {
      return e.toString();
    }

    return '0';
  }

  Future<void> _setUser(String uid, String userName) async {
    print(uid);
    print(userName);
    try {
      var url =
          Uri.parse('https://emcare-expressjs-api.herokuapp.com/new-user');
      await http.post(
        url,
        body: {
          'userid': uid,
          'username': userName,
        },
      );
    } catch (e) {
      print(e.toString());
    }
  }
}
