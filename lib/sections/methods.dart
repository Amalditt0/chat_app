// ignore_for_file: avoid_print

import 'package:chat_app/screens/loginscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// Future<User?> createAccount(String name, String email, String password) async {
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   try {
//     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//         email: email, password: password);

//     // ignore: avoid_print
//     print("Account created Succesfull");

//     UserCredential.user!.updateDisplayName(name);

//     await _firestore.collection('users').doc(_auth.currentUser!.uid).set({
//       "name": name,
//       "email": email,
//       "status": "Unavalible",
//       "uid": _auth.currentUser!.uid,
//     });

//     return userCredential.user;
//   } catch (e) {
//     // ignore: avoid_print
//     print(e);
//     return null;
//   }
// }

// Future<User?> logIn(String email, String password) async {
//   FirebaseAuth _auth = FirebaseAuth.instance;
//   FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   try {
//     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//         email: email, password: password);

//     // ignore: avoid_print
//     print("Login Sucessfull");
//     _firestore
//         .collection('users')
//         .doc(_auth.currentUser!.uid)
//         .get()
//         .then((value) => userCredential.user!.updateDisplayName(value['name']));

//     return userCredential.user;
//   } catch (e) {
//     // ignore: avoid_print
//     print(e);
//     return null;
//   }
// }

// Future logOut(BuildContext context) async {
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   try {
//     await _auth.signOut().then((value) {
//       Navigator.push(
//           context, MaterialPageRoute(builder: (_) => const LoginScreen()));
//     });
//   } catch (e) {
//     // ignore: avoid_print
//     print("error");
//   }
// }

Future<User?> createAccount(String name, String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  FirebaseFirestore _firestore = FirebaseFirestore.instance;

  try {
    User? user = (await _auth.createUserWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Account created successfully");

      // ignore: deprecated_member_use
      user.updateProfile(displayName: name);

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .set({"name": name, "email": email, "status": "Unavailable"});

      return user;
    } else {
      print("Account creation failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future<User?> logIn(String email, String password) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    User? user = (await _auth.signInWithEmailAndPassword(
            email: email, password: password))
        .user;
    if (user != null) {
      print("Login Successfully");
      return user;
    } else {
      print("Login Failed");
      return user;
    }
  } catch (e) {
    print(e);
    return null;
  }
}

Future logOut(BuildContext context) async {
  FirebaseAuth _auth = FirebaseAuth.instance;

  try {
    await _auth.signOut().then((value) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  } catch (e) {
    print("error");
  }
}
