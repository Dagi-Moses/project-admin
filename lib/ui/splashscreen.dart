import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:admin/constants/colors.dart';
import 'package:admin/services/authentication.dart';
import 'package:admin/ui/adduser.dart';
import 'package:admin/ui/homepage.dart';
import 'package:admin/ui/login.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';




class SplashScreenWidget extends StatefulWidget {
  SplashScreenWidget({super.key, });


  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenWidget> {
  
  FirebaseAuth auth = FirebaseAuth.instance;
 /* late bool myBoolValue;
Future<void> _changeValue(bool newValue) async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  myBoolValue =  prefs.getBool('iscoderun') ?? false;
}*/

  
  String _userId = "";

  @override
  void initState()  {
    super.initState();


  

    Future.delayed(Duration(seconds: 2), () async {
      
          if (auth.currentUser != null) {
           // _userId = user.uid;
            Navigator.of(context).pushReplacement( MaterialPageRoute(
              builder: (BuildContext context) => AddUser()));
          }

         else{
         
          await setDefaultUsers();
         
           Navigator.of(context).pushReplacement( MaterialPageRoute(
              builder: (BuildContext context) => LoginPage()));
         }

        
       
  });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: const [splashScreenColorBottom, splashScreenColorTop],
            begin: Alignment.bottomCenter,
            end: Alignment.topRight,
          ),
        ),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              padding: const EdgeInsets.only(top: 80),
              child: SpinKitThreeBounce(
                color: Colors.white,
                size: 30.0,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}