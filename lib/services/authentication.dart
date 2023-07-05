import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
 import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';



 
 

Future<void> setDefaultUsers() async {
  
 

 
final FirebaseAuth _auth = FirebaseAuth.instance;
final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  final String defaultPassword = "terkuma2012";
  
  // User 1
  String name1 = "dagi moses";
  String email1 = "Dagitmoses@gmail.com.com";
  
  // User 2
  String name2 = "sophia dagi";
  String email2 = "sophiadagi@gmail.com";


  try {
    // Create user 1
    UserCredential userCredential1 = await _auth.createUserWithEmailAndPassword(
        email: email1,
        password: defaultPassword
    );
    
    // Set user 1's display name
    await userCredential1.user!.updateDisplayName(name1);

    // Create user 2
    UserCredential userCredential2 = await _auth.createUserWithEmailAndPassword(
        email: email2,
        password: defaultPassword
    );
    
    // Set user 2's display name
    await userCredential2.user!.updateDisplayName(name2);

    // Save user 1's name and email to Firestore
    await _firestore.collection('users').doc(userCredential1.user!.uid).set({
      'name': name1,
      'email': email1,
      'employeeID': '123456'
    });

    // Save user 2's name and email to Firestore
    await _firestore.collection('users').doc(userCredential2.user!.uid).set({
      'name': name2,
      'email': email2,
      'employeeID': '1234567'
    });
  
     //default value set to false if key not found


  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}


  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

 
  Future<User?> signIn(String email, String password) async {
    
    UserCredential result = await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    User? user = result.user;
    return user;
  }


  Future<String> signUp(String email, String password) async {
  try {
    UserCredential result = await firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? user = result.user;
    String uidvar = user!.uid;
    return uidvar;
  } on FirebaseAuthException catch (e) {
    print('Error');
    return e.toString();
  }
}



  Future<User?> getCurrentUser() async {
    User? user =  firebaseAuth.currentUser;
    return user;
  }

 
  Future<void> signOut() async {
    return firebaseAuth.signOut();
  }

 
  Future<void> sendEmailVerification() async {
    User ?user =  firebaseAuth.currentUser;
    user!.sendEmailVerification();
  }

 
  Future<bool> isEmailVerified() async {
   User user =  firebaseAuth.currentUser!;
    return user.emailVerified;
  }
  
