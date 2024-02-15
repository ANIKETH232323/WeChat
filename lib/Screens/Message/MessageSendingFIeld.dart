import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  bool showemoji = false;

  @override
  Widget build(BuildContext context) {
    bool darkmode = false;
    final darkMode1 =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    if (darkMode1 == Brightness.dark) {
      darkmode = true;
    }
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: WillPopScope(
        onWillPop: () {
          if (showemoji) {
            setState(() => showemoji = !showemoji);
            return Future.value(false);
          } else {
            return Future.value(true);
          }
        },
        child: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: Api.getAllMessages(widget
                    .chatUserModel), //the user name should be same as firestore  database collection check that again
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
                          reverse: true,
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
              decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor),
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
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                  showemoji = !showemoji;
                                });
                              },
                              icon: const Icon(
                                  Icons.sentiment_satisfied_alt_outlined,
                                  color: kPrimaryColor)),
                        ),

                        // Message TextField
                        Expanded(
                            child: TextField(
                          controller: textEditingController,
                          maxLines: null,
                          onTap: () {
                            if (showemoji)
                              setState(() => showemoji = !showemoji);
                          },
                          keyboardType: TextInputType.multiline,
                          decoration: const InputDecoration(
                              hintText: "Type Message",
                              border: InputBorder.none),
                        )),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                // Pick multiple  image. that's why using list
                                final List<XFile> images =
                                    await picker.pickMultiImage();

                                for (var i in images) {
                                  Api.sendImage(
                                      widget.chatUserModel, File(i.path));
                                }
                              },
                              icon: const Icon(Icons.photo,
                                  color: kPrimaryColor)),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: IconButton(
                              onPressed: () async {
                                final ImagePicker picker = ImagePicker();
                                // Pick an image.
                                final XFile? image = await picker.pickImage(
                                    source: ImageSource.camera);

                                if (image != null) {
                                  Api.sendImage(
                                      widget.chatUserModel, File(image.path));
                                }
                              },
                              icon: const Icon(Icons.camera_alt,
                                  color: kPrimaryColor)),
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: FloatingActionButton(
                        onPressed: () {
                          if (textEditingController.text.isNotEmpty) {
                            if (list.isEmpty) {
                              Api.sendFirstMessage(widget.chatUserModel,
                                  textEditingController.text, Type.text);
                            } else {
                              Api.sendMessage(widget.chatUserModel,
                                  textEditingController.text, Type.text);
                            }

                            textEditingController.text = '';
                          }
                        },
                        backgroundColor: kPrimaryColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25)),
                        child: const Icon(
                          Icons.send,
                        )),
                  ),
                ],
              ),
            ),
            if (showemoji)
              SizedBox(
                height: 300,
                child: EmojiPicker(
                  textEditingController:
                      textEditingController, // pass here the same [TextEditingController] that is connected to your input field, usually a [TextFormField]
                  config: Config(
                      columns: 7,
                      verticalSpacing: 0,
                      horizontalSpacing: 0,
                      gridPadding: EdgeInsets.zero,
                      bgColor: darkmode == true
                          ? kContentColorLightTheme
                          : Colors.white,
                      indicatorColor: kPrimaryColor,
                      iconColor: kPrimaryColor,
                      iconColorSelected: kPrimaryColor,
                      backspaceColor: kPrimaryColor,
                      skinToneDialogBgColor: kContentColorLightTheme,
                      skinToneIndicatorColor: kContentColorLightTheme,
                      enableSkinTones: true,
                      recentTabBehavior: RecentTabBehavior.RECENT,
                      recentsLimit: 28,
                      loadingIndicator:
                          const SizedBox.shrink(), // Needs to be const Widget
                      tabIndicatorAnimDuration: kTabScrollDuration,
                      categoryIcons: const CategoryIcons(),
                      buttonMode: ButtonMode.MATERIAL,
                      checkPlatformCompatibility: true),
                ),
              )
          ],
        ),
      ),
    );
  }
}
