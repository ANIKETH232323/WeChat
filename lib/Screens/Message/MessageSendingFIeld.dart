import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:wechat/Screens/Message/P2PMessageUI/persont_person_Chat_UI.dart';
import 'package:wechat/Themes/constants.dart';

import '../../Api/Api.dart';
import '../../Model/MessageModel.dart';

class ButtomBodyText extends StatefulWidget {
  const ButtomBodyText({super.key});

  @override
  State<ButtomBodyText> createState() => _ButtomBodyTextState();
}

class _ButtomBodyTextState extends State<ButtomBodyText> {
  List<MessageModel> list = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(
        //   child: ListView.builder(
        //     itemBuilder: (context, index) =>
        //         const P2PUI(),
        //   ),
        // ),

        // Have to check
        // const Expanded(child: P2PUI()),

        Expanded(
          child: StreamBuilder(
            stream: Api
                .getAllMessages(), //the user name should be same as firestore  database collection check that again
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const Center(child: CircularProgressIndicator());

                case ConnectionState.active:
                case ConnectionState.done:
                  // if (snapshot.hasData) {
                  final data = snapshot.data?.docs;
                  log("Data:${jsonEncode(data![0].data())}");
                  //   // list = data
                  //   //     ?.map((e) => ChatUserModel.fromJson(e.data()))
                  //   //     .toList() ??
                  //   //     [];
                  //
                  // }

                  list.add(MessageModel(
                      msg: "Hello",
                      read: '',
                      told: "No",
                      type: Type.text,
                      fromid: Api.user1.uid,
                      sent: "12.05 PM"));
                  list.add(MessageModel(
                      msg: "Hell",
                      read: '',
                      told: Api.user1.uid,
                      type: Type.text,
                      fromid: 'xyz',
                      sent: "01.05 PM"));
                  if (list.isNotEmpty) {
                    return ListView.builder(
                      padding: const EdgeInsets.only(top: 15),
                      physics: const BouncingScrollPhysics(),
                      itemCount: list.length,
                      itemBuilder: (context, index) {
                        return P2PUI(
                          messageModel: list[index],
                        );
                      },
                    );
                  } else {
                    return const Center(
                        child: Text(
                      'Say Hi! 👋',
                      style: TextStyle(fontSize: 20),
                    ));
                  }
              }
            },
          ),
        ),

        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration:
              BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
          child: Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Row(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.sentiment_satisfied_alt_outlined,
                          color: kPrimaryColor),
                    ),
                    Expanded(
                        child: TextField(
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: InputDecoration(
                          hintText: "Type Message", border: InputBorder.none),
                    )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.photo, color: kPrimaryColor),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(Icons.camera_alt, color: kPrimaryColor),
                    ),
                  ]),
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FloatingActionButton(
                    onPressed: () {},
                    backgroundColor: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    child: const Icon(
                      Icons.send,
                    )),
              )
            ],
          ),
        )
      ],
    );
  }
}
