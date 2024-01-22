import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

void checkAuthenticate(context) async {
  FirebaseAuth auth = FirebaseAuth.instance;
  if (auth.currentUser == null) {
    Navigator.pushNamed(context, '/login');
  }
}
