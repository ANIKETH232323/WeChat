import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:wechat/Model/MessageModel.dart';
import 'package:wechat/Model/chatUserModel.dart';

class Api {
  // for Authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for storing self information
  static late ChatUserModel me;

  //For Accessing Firestore cloud database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // For Accessing FireBase Cloud Database

  static FirebaseStorage storage = FirebaseStorage.instance;

  // For not repeating the same code
  static User get user1 => auth.currentUser!;

  // for checking if user exist or not
  static Future<bool> checkUser() async {
    return (await firestore.collection('user').doc(user1.uid).get()).exists;
  }

  // for creating a new user or creating new use account
  static Future<void> createUser() async {
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    final chatUser = ChatUserModel(
        image: auth.currentUser!.photoURL.toString(),
        about: "Hey,I am using WeChat",
        name: auth.currentUser!.displayName.toString(),
        createdAt: time,
        isOnline: false,
        id: auth.currentUser!.uid,
        lastActive: time,
        email: auth.currentUser!.email.toString(),
        pushToken: "");

    return await firestore
        .collection('user')
        .doc(auth.currentUser!.uid)
        .set(chatUser.toJson());
  }

  // getting all user from fire store data base showing in home screen
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser() {
    return firestore
        .collection('user')
        .where('id', isNotEqualTo: user1.uid)
        .snapshots();
  }

  //for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('user').doc(user1.uid).get().then(
      (value) async {
        if (value.exists) {
          me = ChatUserModel.fromJson(value.data()!);
        } else {
          await createUser().then((value) => getSelfInfo());
        }
      },
    );
  }

  // for updating  user info
  static Future<void> UpdateProfileName() async {
    await firestore.collection('user').doc(user1.uid).update({
      'name': me.name,
      'about': me.about,
    });
  }

  // for updating  user info
  static Future<void> updateProfilePicture(File file) async {
    final ext = file.path.split(".").last;
    final ref = storage.ref().child('profile_picture/${user1.uid}.$ext');

    ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then(
          (p0) {},
        );
    me.image = await ref.getDownloadURL();
    await firestore
        .collection('user')
        .doc(user1.uid)
        .update({'image': me.image});
  }

  /// *********************************** Personal Chat Screen Related Api **********************************  ////

  // chats (collection) --> conversation_id (doc) --> messages (collection) --> message (doc)

  // useful for getting conversation id
  static String getConversationID(String id) =>
      user1.uid.hashCode <= id.hashCode
          ? '${user1.uid}_$id'
          : '${id}_${user1.uid}';

  /// for getting all users from firebase database

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(ChatUserModel user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages').orderBy('sent',descending: true)
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(ChatUserModel chatUser, String msg,Type type) async {
    //message sending time (also used as id)
    final time = DateTime.now().millisecondsSinceEpoch.toString();

    //message to send
    final MessageModel message = MessageModel(
        told: chatUser.id,
        msg: msg,
        read: '',
        type: type,
        fromid: user1.uid,
        sent: time);

    final ref = firestore
        .collection('chats/${getConversationID(chatUser.id)}/messages/');
    await ref.doc(time).set(message.toJson());
    //     .then((value) =>
    //     sendPushNotification(chatUser, type == Type.text ? msg : 'image')
    // );
  }

  // Update Message read status
  static Future<void> updateMessageReadStatus(MessageModel messageModel) async {
    firestore
        .collection('chats/${getConversationID(messageModel.fromid)}/messages/')
        .doc(messageModel.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  // get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(ChatUserModel user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages')
        .orderBy('sent',descending: true)
        .limit(1)
        .snapshots();
  }


  // send image to the user
  static Future<void> sendImage(ChatUserModel chatUserModel, File file) async {
    final ext = file.path.split(".").last;
    final ref = storage.ref().child('send_images/${getConversationID(chatUserModel.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then(
          (p0) {},
    );
    final imageUr = await ref.getDownloadURL();
    await sendMessage(chatUserModel, imageUr,Type.image);
  }


  // Getting Specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(ChatUserModel user) {
    return firestore
        .collection('user')
        .where('id',isEqualTo: user.id)
        .snapshots();
  }

  // update last active and online time
  static Future <void> updateActiveStatus(bool online) async {
    firestore
        .collection('user')
        .doc(user1.uid)
        .update({'isOnline':online,'last_active':DateTime.now().millisecondsSinceEpoch.toString()});
  }


}
