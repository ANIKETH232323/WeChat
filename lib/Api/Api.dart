import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart';
import 'package:wechat/Model/MessageModel.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/ignore_files.dart';

class Api {
  // for Authentication
  static FirebaseAuth auth = FirebaseAuth.instance;

  // for storing self information
  static late ChatUserModel me;

  //For Accessing Firestore cloud database
  static FirebaseFirestore firestore = FirebaseFirestore.instance;

  // For Accessing FireBase Cloud Database
  static FirebaseStorage storage = FirebaseStorage.instance;

  // For accessing Firebase messaging push notification
  static FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

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
        image: user1.photoURL.toString(),
        about: "Hey,I am using WeChat",
        name: user1.displayName.toString(),
        createdAt: time,
        isOnline: false,
        id: user1.uid,
        lastActive: time,
        email: user1.email.toString(),
        pushToken: "");

    return await firestore
        .collection('user')
        .doc(user1.uid)
        .set(chatUser.toJson());
  }

  // getting all user from fire store data base showing in home screen
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser(
      List<String> userIds) {
    return firestore
        .collection('user')
        .where('id', whereIn: userIds.isEmpty ? [''] : userIds)
        .snapshots();
  }

  //for getting current user info
  static Future<void> getSelfInfo() async {
    await firestore.collection('user').doc(user1.uid).get().then(
      (value) async {
        if (value.exists) {
          me = ChatUserModel.fromJson(value.data()!);
          getFireBaseMessageToken();
          Api.updateActiveStatus(true);
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

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessages(
      ChatUserModel user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages')
        .orderBy('sent', descending: true)
        .snapshots();
  }

  // for sending message
  static Future<void> sendMessage(
      ChatUserModel chatUser, String msg, Type type) async {
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
    await ref.doc(time).set(message.toJson()).then((value) =>
        sentPushNotification(chatUser, type == Type.text ? msg : 'image'));
  }

  // Update Message read status
  static Future<void> updateMessageReadStatus(MessageModel messageModel) async {
    firestore
        .collection('chats/${getConversationID(messageModel.fromid)}/messages/')
        .doc(messageModel.sent)
        .update({'read': DateTime.now().millisecondsSinceEpoch.toString()});
  }

  // get only last message of a specific chat
  static Stream<QuerySnapshot<Map<String, dynamic>>> getLastMessage(
      ChatUserModel user) {
    return firestore
        .collection('chats/${getConversationID(user.id)}/messages')
        .orderBy('sent', descending: true)
        .limit(1)
        .snapshots();
  }

  // send image to the user
  static Future<void> sendImage(ChatUserModel chatUserModel, File file) async {
    final ext = file.path.split(".").last;
    final ref = storage.ref().child(
        'send_images/${getConversationID(chatUserModel.id)}/${DateTime.now().millisecondsSinceEpoch}.$ext');

    await ref.putFile(file, SettableMetadata(contentType: 'image/$ext')).then(
          (p0) {},
        );
    final imageUr = await ref.getDownloadURL();
    await sendMessage(chatUserModel, imageUr, Type.image);
  }

  // Getting Specific user info
  static Stream<QuerySnapshot<Map<String, dynamic>>> getUserInfo(
      ChatUserModel user) {
    return firestore
        .collection('user')
        .where('id', isEqualTo: user.id)
        .snapshots();
  }

  // update last active and online time
  static Future<void> updateActiveStatus(bool online) async {
    firestore.collection('user').doc(user1.uid).update({
      'isOnline': online,
      'last_active': DateTime.now().millisecondsSinceEpoch.toString(),
      'push_token': me.pushToken
    });
  }

  // for getting firebase messaging token

  static Future<void> getFireBaseMessageToken() async {
    await firebaseMessaging.requestPermission();

    await firebaseMessaging.getToken().then((token) {
      if (token != null) {
        me.pushToken = token;
        log("pushtoken: $token");
      }
    });
  }

  static Future<void> sentPushNotification(
      ChatUserModel chatUserModel, String msg) async {
    final body = {
      "to": chatUserModel.pushToken,
      "notification": {
        "title": me.name, //our name should be send
        "body": msg,
        "android_channel_id": "chats"
      },
      "data": {
        "some_data": "User ID :${me.id}",
      },
    };
    var response = await post(Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
          HttpHeaders.authorizationHeader: serverKey
        },
        body: jsonEncode(body));
    log('Response status: ${response.statusCode}');
    log('Response body: ${response.body}');
  }

//Delete Message
  static Future<void> deleteMessage(MessageModel messageModel) async {
    await firestore
        .collection('chats/${getConversationID(messageModel.told)}/messages/')
        .doc(messageModel.sent)
        .delete();

    if (messageModel.type == Type.image) {
      await storage.refFromURL(messageModel.msg).delete();
    }
  }

// For Update Message after edit
  static Future<void> updateMessage(
      MessageModel messageModel, String updatedMsg) async {
    await firestore
        .collection('chats/${getConversationID(messageModel.told)}/messages/')
        .doc(messageModel.sent)
        .update({'msg': updatedMsg});
  }

  // for adding chat user
  static Future<bool> addChatUser(String email) async {
    final data = await firestore
        .collection('user')
        .where('email', isEqualTo: email)
        .get();

    if (data.docs.isNotEmpty && data.docs.first.id != user1.uid) {
      firestore
          .collection('user')
          .doc(user1.uid)
          .collection('my_users')
          .doc(data.docs.first.id)
          .set({});
      return true;
    } else {
      return false;
    }
  }

  // getting id's of known user in chat home screen
  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllMyUsers() {
    return firestore
        .collection('user')
        .doc(user1.uid)
        .collection('my_users')
        .snapshots();
  }

  // for adding a new user to my user when first message is send
  static Future<void> sendFirstMessage(
      ChatUserModel chatUserModel, String msg, Type type) async {
    await firestore
        .collection('user')
        .doc(chatUserModel.id)
        .collection('my_users')
        .doc(user1.uid)
        .set({}).then((value) => sendMessage(chatUserModel, msg, type));
  }
}
