
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/Screens/Message/MessageSendingFIeld.dart';
import 'package:wechat/Themes/constants.dart';

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
      body: const ButtomBodyText(),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      toolbarHeight: 80,
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: Row(
        children: [
          IconButton(onPressed: (){Navigator.pop(context);}, icon: const Icon(Icons.arrow_back_ios_new_rounded)),
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: CachedNetworkImage(
              height: 40,
              width: 40,
              imageUrl: widget.chatUserModel.image,
              placeholder: (context, url) => const CircularProgressIndicator(),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text(widget.chatUserModel.name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
            Text("Online",style: TextStyle(fontSize: 12,fontWeight: FontWeight.w400)),
          ],)
        ],
      ),
      actions: [
        IconButton(onPressed: (){}, icon:const Icon(Icons.local_phone_rounded)),
        IconButton(onPressed: (){}, icon:const Icon(Icons.videocam)),
        const SizedBox(width: 15,)
      ],
    );
  }
}
