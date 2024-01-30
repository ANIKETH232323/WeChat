import 'package:flutter/material.dart';
import 'package:wechat/Themes/constants.dart';

class HomeListDesign extends StatefulWidget {
  const HomeListDesign({super.key});

  @override
  State<HomeListDesign> createState() => _HomeListDesignState();
}

class _HomeListDesignState extends State<HomeListDesign> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 19,vertical: 5),
      child: Column(
        children: [
          Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: kPrimaryColor
                      ),
                    ),
                  )
                ],
              ),
              const Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 19),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                    Text("Rahul"),
                    SizedBox(height: 10,),
                    Opacity(
                      opacity: 0.64,
                        child: Text("Last Message",maxLines: 1,overflow: TextOverflow.ellipsis,))
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
