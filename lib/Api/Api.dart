import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Api{

  // for Authentication
  static FirebaseAuth auth =FirebaseAuth.instance;


  //For Accessing Firestore cloud database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;
}