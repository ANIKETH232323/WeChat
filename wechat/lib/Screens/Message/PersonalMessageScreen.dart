
import 'package:flutter/material.dart';
import 'package:wechat/Screens/Message/MessageSendingFIeld.dart';
import 'package:wechat/Themes/constants.dart';

class PersonalMessageScreen extends StatelessWidget {
  const PersonalMessageScreen({super.key});

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
      backgroundColor: kPrimaryColor,
      title: Row(
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios)),
          const CircleAvatar(),
          const SizedBox(width: 15),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Text("Aniketh",style: TextStyle(fontSize: 16)),
            Text("Online",style: TextStyle(fontSize: 12)),
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
