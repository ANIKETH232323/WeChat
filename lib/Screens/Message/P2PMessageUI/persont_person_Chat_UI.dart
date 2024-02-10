import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Api/Api.dart';
import 'package:wechat/Model/MessageModel.dart';

import '../../../Themes/constants.dart';

class P2PUI extends StatefulWidget {
  P2PUI({super.key, required this.messageModel});

  final MessageModel messageModel;

  @override
  State<P2PUI> createState() => _P2PUIState();
}

class _P2PUIState extends State<P2PUI> {
  @override
  Widget build(BuildContext context) {
    return Api.user1.uid == widget.messageModel.fromid ? SenderMessageUI() : ReceiverMessageUI();
  }

  Widget SenderMessageUI(){
    return  Padding(
      padding: const EdgeInsets.only(top: 15,left: 15,right: 85),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(child:Icon(CupertinoIcons.person) ),
              const SizedBox(width: 10,),
              Flexible(
                child: SizedBox(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration:  BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                            bottomRight: Radius.circular(28)
                        )
                    ),

                    child:  Stack(
                      children: [
                        Container(
                            margin: const EdgeInsets.only(top: 5,left: 5),
                            child: Text(widget.messageModel.msg)),
                        Container(
                          margin: const EdgeInsets.only(top: 16,left: 75),
                          child: const Icon(Icons.done_all_rounded,size:15,),
                        )
                      ],
                    ),
                  ),
                ),
              ),


            ],),
          Padding(
            padding: EdgeInsets.only(left: 55),
            child: Text(widget.messageModel.sent),
          )
        ],
      ),
    );
  }

  Widget ReceiverMessageUI(){
    return Padding(
      padding: const EdgeInsets.only(top: 15,left: 85,right: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Flexible(
                child: SizedBox(
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: const BoxDecoration(
                        color:kPrimaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                            bottomLeft: Radius.circular(28)
                        )
                    ),

                    child: Text(widget.messageModel.msg),
                  ),
                ),
              ),
              const SizedBox(width: 10,),
              const CircleAvatar(child:Icon(CupertinoIcons.person) ),

            ],),
          Padding(
            padding: EdgeInsets.only(right: 50),
            child: Text(widget.messageModel.sent),
          )
        ],
      ),
    );
  }
}
