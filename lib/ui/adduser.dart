import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/employee.dart';
import 'package:admin/services/authentication.dart';

import 'login.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUSerState createState() => _AddUSerState();
}

class _AddUSerState extends State<AddUser> {
  
  final _formKey = GlobalKey<FormState>();

   String? key;
  int? UID;
   String? Name;
   String? UUID;
   String? PhoneNumber;
   String? Address;
   String? allotted_office;
   String? manager;

 late String email, password;

  FirebaseDatabase db = FirebaseDatabase.instance;
  DatabaseReference ?_managerRef, _officeRef, _userRef, _employeeIDRef;
  String? _errorMessage = '';
  var dropdownValueOffice, dropdownValueManager;
  String managerHintText = "Loading ...", officeHintText = "Loading ...";

  Map<String, dynamic>? officeList  = {
  'office1': {
    'address': '123 Main St',
    'city': 'San Francisco',
    'state': 'CA',
    'name': 'IT'
  },
  'office2': {
    'address': '456 Elm St',
    'city': 'New York',
    'state': 'NY',
    'name': 'accounting'
  },
  'office4': {
    'address': '123 Main St',
    'city': 'San Francisco',
    'state': 'CA',
    'name': 'stationery'
  },
  'office5': {
    'address': '456 Elm St',
    'city': 'New York',
    'state': 'NY',
    'name': 'building'
  }
};
 List<String> officeKeys =[] ;

 Map<String, dynamic> ?managerList  ={
  'John': {
    'age': 30,
    'title': 'field Manager',
    'location': 'San Francisco'
  },
  'Sarah': {
    'age': 28,
    'title': 'Assistant field Manager',
    'location': 'New York'
  },
  'Mike': {
    'age': 35,
    'title': 'Human Resource Manager',
    'location': 'Seattle'
  },
  'Emily': {
    'age': 27,
    'title': 'faculty Manager',
    'location': 'Chicago'
  }
};
 List<String> managerKeys =[];



  @override
  void initState() {
    _managerRef = db.ref().child('managers');
   _managerRef!.set(managerList);

    _officeRef = db.ref().child('location');
    _officeRef!.set(officeList);
    _userRef = db.ref().child('users');
    _employeeIDRef = db.ref().child('employeeID');

    _getOffices();
    _getManagers();

    super.initState();
  }

  void _getOffices() async {
    officeHintText = "Choose Location";
       officeKeys = officeList!.keys.toList();
    _officeRef?.once().then((DataSnapshot snapshot) {
      setState(() {
        officeList =  snapshot.value as  Map<String, dynamic> ;
        officeKeys = officeList!.keys.toList();
        officeHintText = "Choose Location";
      });
      
    } as FutureOr Function(DatabaseEvent value));
  }

  void _getManagers() async {
     managerKeys = managerList!.keys.toList();
     managerHintText = "Choose Manager";
    _managerRef?.once().then((DataSnapshot snapshot) {
      setState((){
        managerList =  snapshot.value as  Map<String, dynamic>;
        managerKeys = managerList!.keys.toList();
        managerHintText = "Choose Manager";
      });
      
    } as FutureOr Function(DatabaseEvent value));
  }
void _logOut() async{
    await signOut();
    Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => LoginPage()),
                  (Route<dynamic> route) => false);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add a new Employee"),
        actions: [ TextButton(
          child: Text("LOGOUT", style: TextStyle(color: Colors.white),),
          onPressed: _logOut,)],
      ),
      body: Container(
        child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Employee ID",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) {
                      String ret;
                      ret =
                          (value!.isEmpty ? 'Employee ID can\'t be empty' : null)!;
                      try {
                        int.parse(value);
                      } catch (e) {
                        ret = "Enter numeric value only";
                      }
                      return ret;
                    },
                    onChanged: (value) {setState(() {
                      UID = int.parse(value);
                    });}
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Name",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'Name can\'t be empty' : null,
                    onChanged: (value) {setState(() {
                      Name = value;
                    });}
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'Email can\'t be empty' : null,
                    onChanged: (value) { setState(() {
                      email = value;
                    });}
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'Password can\'t be empty' : null,
                    onChanged: (value) {setState(() {
                       password = value;
                    });}
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "UUID",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'UUID can\'t be empty' : null,
                    onChanged: (value) { setState(() {
                      UUID = value;
                    });}
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Phone Number",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) {
                      String ret;
                      ret =
                          (value!.isEmpty ? 'Phone Number can\'t be empty' : null)!;

                      if (value.length != 10)
                        ret = "Enter 10-digit phone number";

                      return ret;
                    },
                    onChanged: (value) { setState(() {
                      PhoneNumber = value;
                    });}
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Address",
                        hintStyle: TextStyle(color: Colors.grey[400])),
                    validator: (value) =>
                        value!.isEmpty ? 'Address can\'t be empty' : null,
                    onChanged: (value) {setState(() {
                      Address = value;
                      
                    });}
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: DropdownButton<String>(
                    hint: Text(officeHintText),
                    value: allotted_office,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                    ),
                     
                    onChanged: (String ?newValue) {
                      setState(() {
                        print(newValue);
                        allotted_office = newValue!;
                      });
                    },
                    items: 
                    officeKeys != null
                        ? officeKeys
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(officeList![value]["name"]),
                            );
                          }).toList()
                        : [],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  child: DropdownButton<String>(
                    hint: Text(managerHintText),
                    value: manager,
                    iconSize: 24,
                    elevation: 16,
                    underline: Container(
                      height: 2,
                    ),
                    onChanged: (String? newValue) {
                      setState(() {
                        print(newValue);
                        manager = newValue!;
                      });
                    },
                    items: managerKeys != null
                        ? managerKeys
                            .map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(managerList![value]["title"]),
                            );
                          }).toList()
                        : [],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: _errorMessage != null
                      ? (Text(_errorMessage!))
                      : Container(),
                ),
                Container(
                    padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                    child: Center(
                        child: ElevatedButton(
                      child: Text("Add Employee", style: TextStyle(color: Colors.white)),
                      onPressed: () { 
                        if(_formKey.currentState!.validate()){createUser(context);}
                        },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue
                    ),
                    ))),
                     Container(
                    padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                    child: Center(
                        child: ElevatedButton(
                      child: Text("Reset Form", style: TextStyle(color: Colors.white)),
                      onPressed: () { _errorMessage = ''; _formKey.currentState!.reset();
                      
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red
                      ),
                    )))
              ],
            )),
      ),
    );
  }

  

  void createUser(BuildContext context) async {
   Employee employee = Employee(UID, Name, UUID, PhoneNumber, Address, allotted_office, manager,  );
 if (email != null && password != null && _userRef != null && _employeeIDRef!= null) {
    try {
          signUp(email, password);
        //  .then((String value)  {
           
        
          
          _userRef?.child('userss').set(employee.toJson());
          _employeeIDRef?.child(UID.toString()).set(email);
          showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
            title: Text("User Added Successfully"),
            content: Text(
                "User can start using his account through his employee ID and password."),
          );  });
         
      //});
    } catch (e) {
      print("in catch");
       showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
            title: Text("error"),
            content: Text(
                e.toString()),
          );  });
      print(e.toString());
    }
}else{
  showDialog(
            context: context, 
            builder: (BuildContext context) {
              return AlertDialog(
            title: Text("error"),
            content: Text(
                'bullshit'));
});  
      
}
  }
}
