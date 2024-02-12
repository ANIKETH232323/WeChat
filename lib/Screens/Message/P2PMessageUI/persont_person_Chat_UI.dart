import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Api/Api.dart';
import 'package:wechat/Model/MessageModel.dart';
import 'package:wechat/timeFormater.dart';

import '../../../Themes/constants.dart';

class P2PUI extends StatefulWidget {
  const P2PUI({super.key, required this.messageModel});

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

    bool hello = false;
    if(widget.messageModel.read.isNotEmpty){
      hello = true;
    }
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

                        // if(widget.messageModel.read.isNotEmpty)
                        hello ? Container(
                          margin: const EdgeInsets.only(top: 16,left: 75),
                          child:  const Icon(Icons.done_all_rounded,size:15,),
                        ) : Container(
                        margin: const EdgeInsets.only(top: 16,left: 75),
                        child:  Icon(Icons.done,size:15,)),
                      ],
                    ),
                  ),
                ),
              ),


            ],),
          Padding(
            padding: const EdgeInsets.only(left: 55),
            child: Text(TimeFormat.getFormatedTime(context: context, time: widget.messageModel.sent)),
          )
        ],
      ),
    );
  }

  Widget ReceiverMessageUI(){

    // update last receiver message if sender and receiver both are different
    if(widget.messageModel.read.isEmpty){
      Api.updateMessageReadStatus(widget.messageModel);
    }

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

              // person icon
              const CircleAvatar(child:Icon(CupertinoIcons.person) ),

            ],),

          //date time
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text(TimeFormat.getFormatedTime(context: context, time: widget.messageModel.sent)),
          )
        ],
      ),
    );
  }
}
