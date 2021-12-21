import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AppUser {
  String id;
  String name;
  String sex;
  int age;
  String profilePhotoPath;
  String bio = "";

  AppUser(
      {@required this.id,
        @required this.sex,
      @required this.name,
      @required this.age,
      @required this.profilePhotoPath});

  AppUser.fromSnapshot(DocumentSnapshot snapshot) {
    id = snapshot['id'];
    name = snapshot['name'];
    sex = snapshot['sex'];
    age = snapshot['age'];
    profilePhotoPath = snapshot['profile_photo_path'];
    bio = snapshot.get('bio') ?? '';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'age': age,
      'sex': sex,
      'profile_photo_path': profilePhotoPath,
      'bio': bio
    };
  }
}
