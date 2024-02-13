import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wechat/Api/Api.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/Screens/LoginDetails/LoginScreen1.dart';
import 'package:wechat/dialoge_box/snackBar.dart';
import 'package:wechat/timeFormater.dart';

import '../../Themes/constants.dart';

class ChatReceiverProfileScreen extends StatefulWidget {
  final ChatUserModel chatUserModel;
  const ChatReceiverProfileScreen({super.key, required this.chatUserModel});

  @override
  State<ChatReceiverProfileScreen> createState() =>
      _ChatReceiverProfileScreenState();
}

class _ChatReceiverProfileScreenState extends State<ChatReceiverProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            // Top App bar Green
            Container(
              height: 300,
              decoration: const BoxDecoration(color: kPrimaryColor),
            ),

            // The Whole Card Box
            Container(
              margin: const EdgeInsets.only(top: 200, right: 15, left: 15),
              height: 370,
              width: 450,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: titleColor.withOpacity(.1),
                        blurRadius: 20,
                        spreadRadius: 10),
                  ]),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    // No 1 - Some Space
                    Column(
                      children: <Widget>[
                        // Some Space
                        const SizedBox(
                          height: 65,
                        ),

                        // Log in User Name and Text Form Field
                        SizedBox(
                            width: 250,
                            // Text Form FIeld
                            child: Text(
                              widget.chatUserModel.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 20),
                              textAlign: TextAlign.center,
                            )),

                        // Space
                        const SizedBox(
                          height: 10,
                        ),

                        // Joined Date and Time
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text(
                              'Joined On',
                              style: TextStyle(color: textColor, fontSize: 15),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              TimeFormat.getLastMessFormTime(
                                  context: context,
                                  time: widget.chatUserModel.createdAt,
                                  showYear: true),
                              style: const TextStyle(
                                  color: textColor, fontSize: 15),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Email Box
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 30.0, left: 15.0, right: 15.0),
                      child: Column(
                        children: [
                          // Email Box
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 5),
                                      color: Colors.grey.withOpacity(.2),
                                      spreadRadius: 2,
                                      blurRadius: 10)
                                ]),
                            child: ListTile(
                              title: const Text("Email"),
                              subtitle: Text(widget.chatUserModel.email),
                              leading: const Icon(Icons.email),
                            ),
                          ),

                          // Space
                          const SizedBox(
                            height: 15,
                          ),

                          // About Box
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      offset: const Offset(0, 5),
                                      color: Colors.grey.withOpacity(.2),
                                      spreadRadius: 2,
                                      blurRadius: 10)
                                ]),
                            child: ListTile(
                              title: const Text("About"),
                              subtitle: SizedBox(
                                  height: 25,
                                  child: Text(
                                    widget.chatUserModel.about,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                              leading: const Icon(
                                  CupertinoIcons.refresh_circled_solid),
                              tileColor: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // END HERE

            // Top App bar back button and Edit Profile Text
            Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Back Button
                  Padding(
                    padding: const EdgeInsets.only(top: 40, left: 5),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),

            // Edit Profile Text and The Profile Picture and The edit button
            Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 105,
                  ),
                  Stack(
                    children: [
                      // Firebase Defult Profile Picture
                      SizedBox(
                        height: 145,
                        width: 145,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: CachedNetworkImage(
                            width: 25,
                            height: 25,
                            fit: BoxFit.cover,
                            imageUrl: widget.chatUserModel.image,
                            errorWidget: (context, url, error) =>
                                const CircleAvatar(
                                    child: Icon(CupertinoIcons.person)),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
