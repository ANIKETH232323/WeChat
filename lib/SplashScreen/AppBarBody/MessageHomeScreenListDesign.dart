import 'package:flutter/material.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/Themes/constants.dart';

class HomeListDesign extends StatefulWidget {

  final ChatUserModel userModel;
  const HomeListDesign({super.key, required this.userModel});

  @override
  State<HomeListDesign> createState() => _HomeListDesignState();
}

class _HomeListDesignState extends State<HomeListDesign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 19,vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor
                      ),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text(widget.userModel.name),
                    const SizedBox(height: 10,),
                    Opacity(
                      opacity: 0.64,
                        child: Text(widget.userModel.about,maxLines: 1,overflow: TextOverflow.ellipsis,))
                  ],),
                ),
              ),

              Opacity(opacity: 0.64,child: Text("8.14 PM")),

            ],
          ),
          const Divider(indent: 5,thickness: 2,color: Colors.black38,)
        ],
      ),
    );
  }
}
