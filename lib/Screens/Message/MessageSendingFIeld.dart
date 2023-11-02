import 'package:flutter/material.dart';
import 'package:wechat/Screens/Message/P2PMessageUI/persont_person_Chat_UI.dart';
import 'package:wechat/Themes/constants.dart';

class ButtomBodyText extends StatelessWidget {
  const ButtomBodyText({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Expanded(
        //   child: ListView.builder(
        //     itemBuilder: (context, index) =>
        //         const P2PUI(),
        //   ),
        // ),
        const Expanded(child: P2PUI()),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor
          ),
          child: Row(
            children: [
              const SizedBox(width: 10,),
              Expanded(
                child: Container(
                  height: 60,
                  decoration: BoxDecoration(
                      color: kPrimaryColor.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(50)
                  ),
                  child: const Row(children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.sentiment_satisfied_alt_outlined,color: kPrimaryColor),
                    ),
                    Expanded(
                        child: TextField(
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          decoration: InputDecoration(
                              hintText: "Type Message",
                              border: InputBorder.none
                          ),
                        )),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.photo,color: kPrimaryColor),
                    ),
                    Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Icon(Icons.camera_alt,color: kPrimaryColor),
                    ),
                  ]),
                ),
              ),
              const SizedBox(width: 5),
              Padding(
                padding: const EdgeInsets.only(right: 10),
                child: FloatingActionButton(onPressed: (){},
                    backgroundColor: kPrimaryColor,
                    child:const Icon(Icons.send,)
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
