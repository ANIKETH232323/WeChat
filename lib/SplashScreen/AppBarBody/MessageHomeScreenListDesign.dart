import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:wechat/Model/chatUserModel.dart';
import 'package:wechat/Screens/Message/PersonalMessageScreen.dart';
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
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => PersonalMessageScreen(chatUserModel: widget.userModel),));
        },
        child: Column(
          children: [
            Row(
              children: [
                Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: CachedNetworkImage(
                        height: 40,
                        width: 40,
                        imageUrl: widget.userModel.image,
                        placeholder: (context, url) => const CircularProgressIndicator(),
                        errorWidget: (context, url, error) => const Icon(Icons.error),
                      ),
                    ),


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
                    padding: const EdgeInsets.symmetric(horizontal: 19),
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

                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Container(
                    height: 15,
                    width: 15,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(25)
                    ),
                  ),
                )

              ],
            ),
            const Divider(indent: 5,thickness: 2,color: Colors.black38,)
          ],
        ),
      ),
    );
  }
}
