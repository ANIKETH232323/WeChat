import 'package:flutter/material.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/Screens/Message/P2PMessageUI/persont_person_Chat_UI.dart';
import 'package:wechat/Themes/constants.dart';

import '../../Api/Api.dart';
import '../../Model/MessageModel.dart';

class ButtomBodyText extends StatefulWidget {
  final ChatUserModel chatUserModel;
  const ButtomBodyText({super.key, required this.chatUserModel});

  @override
  State<ButtomBodyText> createState() => _ButtomBodyTextState();
}

class _ButtomBodyTextState extends State<ButtomBodyText> {
  List<MessageModel> list = [];

  //for handling message text changes
  final TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: StreamBuilder(
            stream: Api
                .getAllMessages(widget.chatUserModel), //the user name should be same as firestore  database collection check that again
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                case ConnectionState.none:
                  return const SizedBox();

                case ConnectionState.active:
                case ConnectionState.done:
                  // if (snapshot.hasData) {
                  final data = snapshot.data?.docs;
                  // log("Data:${jsonEncode(data![0].data())}");
                    list = data
                        ?.map((e) => MessageModel.fromJson(e.data()))
                        .toList() ??
                        [];

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
                  child: Row(children: [
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.sentiment_satisfied_alt_outlined,
                          color: kPrimaryColor),
                    ),
                    Expanded(
                        child: TextField(
                          controller: textEditingController,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                          hintText: "Type Message", border: InputBorder.none),
                    )),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.photo, color: kPrimaryColor),
                    ),
                    const Padding(
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
                    onPressed: () {
                      if(textEditingController.text.isNotEmpty){
                        Api.sendMessage(widget.chatUserModel, textEditingController.text);
                        textEditingController.text = '';
                      }
                    },
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
