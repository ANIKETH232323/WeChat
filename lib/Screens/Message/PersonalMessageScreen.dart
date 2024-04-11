
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Api/Api.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/Screens/Message/MessageSendingFIeld.dart';
import 'package:wechat/Themes/constants.dart';
import 'package:wechat/timeFormater.dart';

import '../../SplashScreen/AppBarBody/chatUserProfileScreen.dart';

class PersonalMessageScreen extends StatefulWidget {
  final ChatUserModel chatUserModel;
  const PersonalMessageScreen({super.key, required this.chatUserModel});

  @override
  State<PersonalMessageScreen> createState() => _PersonalMessageScreenState();
}

class _PersonalMessageScreenState extends State<PersonalMessageScreen> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: buildAppBar(),
      body: ButtomBodyText(chatUserModel:widget.chatUserModel),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: StreamBuilder(
          stream: Api.getUserInfo(widget.chatUserModel),
          builder: (context, snapshot) {

            final data = snapshot.data?.docs;
            final list = data
                ?.map((e) => ChatUserModel.fromJson(e.data()))
                .toList() ??
                [];



           return Row(
              children: [
                IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new_rounded)),


                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatReceiverProfileScreen(chatUserModel: widget.chatUserModel),));
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(25),
                    child: CachedNetworkImage(
                      height: 40,
                      width: 40,
                      imageUrl: list.isNotEmpty ?list[0].image : widget.chatUserModel.image,
                      placeholder: (context, url) => const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const Icon(Icons.error,),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatReceiverProfileScreen(chatUserModel: widget.chatUserModel),));
                  },
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(list.isNotEmpty ?list[0].name : widget.chatUserModel.name,style: const TextStyle(fontSize: 16,fontFamily: 'OnePlus',fontWeight:FontWeight.bold),),
                      Text(list.isNotEmpty ?
                          list[0].isOnline ? 'Online'
                              :
                      TimeFormat.getLastActiveTime(context: context, lastActive: list[0].lastActive)
                          :
                      TimeFormat.getLastActiveTime(context: context, lastActive:widget.chatUserModel.lastActive),style: const TextStyle(fontSize: 12,fontFamily: 'OnePlus',fontWeight:FontWeight.bold)),
                    ],),
                )
              ],
            );
          },
      ),

      // Will be implement later
      // actions: [
      //   IconButton(onPressed: (){}, icon:const Icon(Icons.local_phone_rounded)),
      //   IconButton(onPressed: (){}, icon:const Icon(Icons.videocam)),
      //   const SizedBox(width: 15,)
      // ],
    );
  }
}
