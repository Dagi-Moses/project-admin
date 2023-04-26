import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

class Employee{
  
   String ? key;
  int? UID;
   String? Name;
 String? UUID;
  String? PhoneNumber;
  String? Address;
   String? allotted_office;
   String? manager;

  
  Employee(   this.UID,  this.Name, this.UUID, this.PhoneNumber, this.Address,  this.allotted_office, this.manager, );

  Employee.fromSnapshot( DataSnapshot snapshot ) :
  
  
    key = snapshot.key,
    UID = (snapshot.value as Map<dynamic, dynamic>)['UID'] ,
    Name = (snapshot.value as Map<dynamic, dynamic>)["Name"],
    PhoneNumber = (snapshot.value as Map<dynamic, dynamic>)["PhoneNumber"],
    Address = (snapshot.value as Map<dynamic, dynamic>)["Address"],
    allotted_office = (snapshot.value as Map<dynamic, dynamic>)["allotted_office"],
    manager = (snapshot.value as Map<dynamic, dynamic>)["manager"];

  toJson() {
    return {
      "UID": UID, 
      "Name": Name,
      "UUID": UUID,
      "PhoneNumber": PhoneNumber,
      "Address": Address,
      "allotted_office": allotted_office,
      "manager": manager,
    };

    
  }
  
}
