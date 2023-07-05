import 'package:admin/ui/splashscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/services/authentication.dart';
import 'package:admin/ui/adduser.dart';
import 'package:admin/ui/homepage.dart';
import 'package:admin/ui/login.dart';

import 'firebase_options.dart';

Future <void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
    Stream<User?> get user{
      final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    return firebaseAuth.authStateChanges();
  }
  @override
  Widget build(BuildContext context) {
  
    return StreamProvider.value(
      value: user,
      initialData: null,
      child: MaterialApp(
            title: 'Flutter login demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home:  
            LoginPage(),
            ),
    );
   
  }
}

