import 'package:flutter/material.dart';
import 'package:admin/services/authentication.dart';
import 'package:admin/ui/login.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("LOGOUT"),
          onPressed: _logOut,))
    );
  }

  void _logOut() async{
    await signOut();
    Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
  }
}