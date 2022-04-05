import 'dart:ffi';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? tinkoff_token;
  bool? admin;

  UserModel({this.uid, this.email, this.firstName, this.secondName, this.admin, this.tinkoff_token});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      tinkoff_token: map('tinkoff_token'),
      admin: map['admin']
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'tinkoff_token': tinkoff_token,
      'admin': admin
    };
  }
}