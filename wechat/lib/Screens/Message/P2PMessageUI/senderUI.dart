import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Themes/constants.dart';

class SenderMessageUI extends StatelessWidget {
  const SenderMessageUI({super.key});

  @override
  Widget build(BuildContext context) {
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
                        margin: EdgeInsets.only(top: 5,left: 5),
                          child: const Text("Heqqwiolo")),
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
          const Padding(
            padding: EdgeInsets.only(left: 55),
            child: Text("2.30 PM",),
          )
        ],
      ),
    );
  }
}
