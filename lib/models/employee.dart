import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class Employee {
  //String key;
  int UID;
  String Name;
  String UUID;
  String PhoneNumber;
  String Address;
  String allotted_office;
  String manager;

  Employee({
    //required this.key,
    required this.UID,
    required this.Name,
    required this.UUID,
    required this.PhoneNumber,
    required this.Address,
    required this.allotted_office,
    required this.manager,
  });

  Employee.fromSnapshot(DataSnapshot snapshot)
     : // : key = snapshot.key,
        UID = (snapshot.value as Map<dynamic, dynamic>)['UID'],
        Name = (snapshot.value as Map<dynamic, dynamic>)["Name"],
        PhoneNumber = (snapshot.value as Map<dynamic, dynamic>)["PhoneNumber"],
        UUID=  (snapshot.value as Map<dynamic, dynamic>)["UUID"],
        Address = (snapshot.value as Map<dynamic, dynamic>)["Address"],
        allotted_office =
            (snapshot.value as Map<dynamic, dynamic>)["allotted_office"],
        manager = (snapshot.value as Map<dynamic, dynamic>)["manager"];

  toJson() {
    return {
      "UID": UID ?? ' ',
      "Name": Name ?? ' ',
      "UUID": UUID ?? ' ',
      "PhoneNumber": PhoneNumber ?? ' ',
      "Address": Address ?? ' ',
      "allotted_office": allotted_office ?? ' ',
      "manager": manager ?? ' ',
    };
  }
}
