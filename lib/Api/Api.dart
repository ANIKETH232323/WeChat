import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wechat/Model/chatUserModel.dart';

class Api{

  // for Authentication
  static FirebaseAuth auth = FirebaseAuth.instance;


  //For Accessing Firestore cloud database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // For not repeating the same code
  static User get user1 => auth.currentUser!;

  // for checking if user exist or not
  static Future<bool> checkUser() async{
    return (await firestore.collection('user').doc(user1.uid).get()).exists;
  }

  // for creating a new user or creating new use account
  static Future<void> createUser() async{
    
    final time  = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUserModel(
        image: auth.currentUser!.photoURL.toString(),
        about: "Hey,I am using WeChat",
        name: auth.currentUser!.displayName.toString(),
        createdAt: time, isOnline: false, id: auth.currentUser!.uid ,
        lastActive: time, email: auth.currentUser!.email.toString(), pushToken: "");

    return await firestore.collection('user').doc(auth.currentUser!.uid).set(chatUser.toJson());
  }

}