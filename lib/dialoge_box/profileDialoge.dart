import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/Screens/Message/PersonalMessageScreen.dart';
import 'package:wechat/SplashScreen/AppBarBody/chatUserProfileScreen.dart';
import 'package:wechat/Themes/constants.dart';

class ProfileDialoge extends StatefulWidget {
  const ProfileDialoge({super.key, required this.chatUserModel});
  final ChatUserModel chatUserModel;

  @override
  State<ProfileDialoge> createState() => _ProfileDialogeState();
}

class _ProfileDialogeState extends State<ProfileDialoge> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white.withOpacity(.9),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
        content: SizedBox(
            width: 360,
            height: 350,
            child: Stack(
                children: [

                  Positioned(
                      top: 300,
                      child: Container(
                        width: 332,height: 50,decoration: const BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.only(
                              bottomLeft:Radius.circular(20),
                              bottomRight: Radius.circular(20))
                      ),)

                  ),
              //user profile picture
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: CachedNetworkImage(
                        width:170,
                        height: 170,
                        imageUrl: widget.chatUserModel.image,
                        fit: BoxFit.cover,
                        errorWidget: (context, url, error) =>
                            const CircleAvatar(child: Icon(CupertinoIcons.person)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  Text(widget.chatUserModel.name,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w700),)
                  
                ],
              ),




              //info button
              Positioned(
                top: 300,
                right: 120,
                child: Row(
                  children: [


                    MaterialButton(
                      onPressed: () {
                        //for hiding image dialog
                        Navigator.pop(context);

                        //move to view profile screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => PersonalMessageScreen(chatUserModel: widget.chatUserModel)));
                      },
                      minWidth: 0,
                      padding: const EdgeInsets.all(0),
                      shape: const CircleBorder(),
                      child: const Icon(Icons.messenger,
                          color: Colors.black87, size: 30),
                    ),
                    MaterialButton(
                      onPressed: () {
                        //for hiding image dialog
                        Navigator.pop(context);

                        //move to view profile screen
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ChatReceiverProfileScreen(chatUserModel: widget.chatUserModel)));
                      },
                      minWidth: 0,
                      padding: const EdgeInsets.all(0),
                      shape: const CircleBorder(),
                      child: const Icon(Icons.info_outline,
                          color: Colors.black87, size: 30),
                    ),


                  ],
                ),
              )


            ])));
  }
}
