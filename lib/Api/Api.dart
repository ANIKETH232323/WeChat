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
    
    final time  = DateTime.now().microsecondsSinceEpoch.toString();

    final chatUser = ChatUserModel(image: user1.photoURL.toString(), about: "Hey,I am using WeChat", name: user1.displayName.toString(),
        createdAt: time, isOnline: false, id: user1.uid ,
        lastActive: time, email: user1.email.toString(), pushToken: "");

    return await firestore.collection('user').doc(user1.uid).set(chatUser.toJson());
  }

}