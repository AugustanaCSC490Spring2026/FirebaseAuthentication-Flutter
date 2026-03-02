import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../home.dart';
import '../login.dart';

// credits to @MahdiNazmi for source code
// github link: https://github.com/mahdinazmi/Flutter-Firebase-Auth/commit/6169e61dbb827bbb82dbda0c45ea303558d08762

class AuthService {
   Future<void> signup({
    required String email, 
    required String password,
    required BuildContext context
   }) async{

  
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: email, 
         password: password
      );
      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context, 
        MaterialPageRoute(
          builder: (BuildContext context)=> const Home ()
        )
      );
    } on FirebaseAuthException catch(e){
      String message = '';
      if(e.code == 'weak-password'){
        message = 'The passowrd is too weak, Please try another one';
      } else if (e.code == 'email-already-in-use'){
        message = 'The email is already in use. Please try another one';
      }
      Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0, 
      );
    }
    catch(e){
    }
   }
   Future<void> signin({
    required String email,
    required String password,
    required BuildContext context
  }) async {
    
    try {

      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password
      );

      await Future.delayed(const Duration(seconds: 1));
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const Home()
        )
      );
      
    } on FirebaseAuthException catch(e) {
      String message = '';
      if (e.code == 'invalid-email') {
        message = 'No user found for that email.';
      } else if (e.code == 'invalid-credential') {
        message = 'Wrong password provided for that user.';
      }
       Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.black54,
        textColor: Colors.white,
        fontSize: 14.0,
      );
    }
    catch(e){
    }
  }
  Future<void> signout({
    required BuildContext context
  }) async {
    
    await FirebaseAuth.instance.signOut();
    await Future.delayed(const Duration(seconds: 1));
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) =>Login()
        )
      );
  }
}
  