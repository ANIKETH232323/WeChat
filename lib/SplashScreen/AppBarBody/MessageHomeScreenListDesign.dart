import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Api/Api.dart';
import 'package:wechat/Model/MessageModel.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/Screens/Message/PersonalMessageScreen.dart';
import 'package:wechat/dialoge_box/profileDialoge.dart';
import 'package:wechat/timeFormater.dart';

class HomeListDesign extends StatefulWidget {
  final ChatUserModel userModel;
  const HomeListDesign({super.key, required this.userModel});

  @override
  State<HomeListDesign> createState() => _HomeListDesignState();
}

class _HomeListDesignState extends State<HomeListDesign> {
  MessageModel? messageModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  PersonalMessageScreen(chatUserModel: widget.userModel),
            ));
      },
      child: StreamBuilder(
        stream: Api.getLastMessage(widget.userModel),
        builder: (context, snapshot) {
          final data = snapshot.data?.docs;
          final list =
              data?.map((e) => MessageModel.fromJson(e.data())).toList() ?? [];
          if (list.isNotEmpty) {
            messageModel = list[0];
          }

          return ListTile(

                  leading: InkWell(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) => ProfileDialoge(
                            chatUserModel: widget.userModel,
                          ));
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        height: 40,
                        width: 40,
                        imageUrl: widget.userModel.image,
                        placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                        const Icon(Icons.error_outline_rounded),
                      ),
                    ),
                  ),
                  title: Text(
                    widget.userModel.name,
                    style: const TextStyle(fontFamily: 'OnePlus',fontWeight:FontWeight.bold),
                  ),
                  subtitle: Opacity(
                      opacity: 0.85,
                      child: Text(
                        messageModel != null
                            ? messageModel!.type == Type.image
                            ? 'Photo'
                            : messageModel!.msg
                            : widget.userModel.about,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontFamily: 'OnePlus',fontWeight:FontWeight.bold),
                      )),
                  trailing: messageModel == null
                      ? null
                      : messageModel!.read.isEmpty &&
                      messageModel!.fromid != Api.user1.uid
                      ? Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(25)),
                  )
                      : Text(TimeFormat.getLastMessFormTime(
                      context: context, time: messageModel!.sent),style: const TextStyle(fontFamily: 'OnePlus',fontWeight:FontWeight.bold),));
        },
      ),
    );
  }
}
