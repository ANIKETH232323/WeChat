import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:wechat/Api/Api.dart';
import 'package:wechat/Model/MessageModel.dart';
import 'package:wechat/dialoge_box/snackBar.dart';
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
    bool isme = Api.user1.uid == widget.messageModel.fromid;
    return InkWell(
      onLongPress: () {
        _showBottomsheet(isme);
      },
      child: isme ? SenderMessageUI() : ReceiverMessageUI(),
    );
  }

  Widget SenderMessageUI() {
    bool hello = false;
    if (widget.messageModel.read.isNotEmpty) {
      hello = true;
    }

    bool imag = false;

    if (widget.messageModel.type == Type.image) {
      imag = true;
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 15, right: 85),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              // person icon  will be implement later
              // const CircleAvatar(child: Icon(CupertinoIcons.person)),
              const SizedBox(
                width: 10,
              ),
              Flexible(
                child: SizedBox(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: kPrimaryColor.withOpacity(0.2),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                            bottomRight: Radius.circular(28))),
                    child: Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 5, left: 5),
                          child: widget.messageModel.type == Type.text
                              ? Text(widget.messageModel.msg)
                              : Padding(
                                  padding: const EdgeInsets.only(right: 15.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: CachedNetworkImage(
                                      width: 280,
                                      height: 150,
                                      fit: BoxFit.cover,
                                      imageUrl: widget.messageModel.msg,
                                      errorWidget: (context, url, error) =>
                                          const CircleAvatar(
                                              child:
                                                  Icon(Icons.image_outlined)),
                                    ),
                                  ),
                                ),
                        ),

                        // if(widget.messageModel.read.isNotEmpty)
                        hello
                            ? Container(
                                margin: imag
                                    ? const EdgeInsets.only(top: 155, left: 235)
                                    : const EdgeInsets.only(top: 25, left: 85),
                                child: const Icon(
                                  Icons.done_all_rounded,
                                  size: 15,
                                ),
                              )
                            : Container(
                                margin: imag
                                    ? const EdgeInsets.only(top: 150, left: 230)
                                    : const EdgeInsets.only(top: 16, left: 75),
                                child: const Icon(
                                  Icons.done,
                                  size: 15,
                                )),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 55),
            child: Text(TimeFormat.getFormatedTime(
                context: context, time: widget.messageModel.sent)),
          )
        ],
      ),
    );
  }

  Widget ReceiverMessageUI() {
    // update last receiver message if sender and receiver both are different
    if (widget.messageModel.read.isEmpty) {
      Api.updateMessageReadStatus(widget.messageModel);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 15, left: 85, right: 15),
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
                        color: kPrimaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(28),
                            topRight: Radius.circular(28),
                            bottomLeft: Radius.circular(28))),
                    child: widget.messageModel.type == Type.text
                        ? Text(widget.messageModel.msg)
                        : Padding(
                            padding: const EdgeInsets.only(right: 15.0),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: CachedNetworkImage(
                                width: 280,
                                height: 150,
                                fit: BoxFit.cover,
                                imageUrl: widget.messageModel.msg,
                                errorWidget: (context, url, error) =>
                                    const CircleAvatar(
                                        child: Icon(Icons.image_outlined)),
                              ),
                            ),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),

              // person icon
              // const CircleAvatar(child: Icon(CupertinoIcons.person)),
            ],
          ),

          //date time
          Padding(
            padding: const EdgeInsets.only(right: 50),
            child: Text(TimeFormat.getFormatedTime(
                context: context, time: widget.messageModel.sent)),
          )
        ],
      ),
    );
  }



  void _showBottomsheet(bool isme){
    showModalBottomSheet(
      showDragHandle: true,
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(35),topRight: Radius.circular(35))),
      builder: (_) {

        return ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(bottom: 65),
          children:[
            //Copy Option
            widget.messageModel.type == Type.text ?
            OptionItem(icon: const Icon(Icons.copy_all), iconName: 'Copy', onTap: () async {
              await Clipboard.setData(
                  ClipboardData(text: widget.messageModel.msg))
                  .then((value) {
                //for hiding bottom sheet
                Navigator.pop(context);
              });
            }
            ,)
                :
            // Save Option For Image
            OptionItem(icon: const Icon(Icons.download), iconName: 'Save Image', onTap: () async {

              try{
                await GallerySaver.saveImage(widget.messageModel.msg,albumName: "WeChat").then((success) {
                  Navigator.pop(context);
                  if(success != null && success) {
                    SnackBar1.showFloatingSnackBar(context, "Image Saved");
                  }
                });
              }
              catch(e){
                log("Error While Saving Image: $e");
              }

            },),

            //separator or divider
            if(isme)
            const Divider(
              color: Colors.black54,
              endIndent: 20,
              indent: 20,
            ),

            //Edit Option
            if(widget.messageModel.type == Type.text && isme)
            OptionItem(icon: const Icon(Icons.edit_note_sharp), iconName: 'Edit Message', onTap: () {

              Navigator.pop(context);
              showMessageUpdateDialoge();


            },),

            // Delete Option
            if(isme)
            OptionItem(icon: const Icon(Icons.delete), iconName: 'Delete', onTap: () {

              Api.deleteMessage(widget.messageModel).then((value) {
                Navigator.pop(context);
              },);
            },),

            //separator or divider
            const Divider(
              color: Colors.black54,
              endIndent: 20,
              indent: 20,
            ),

            // Sent Time
            OptionItem(icon: const Icon(Icons.remove_red_eye,color: kPrimaryColor,),
              iconName: 'Sent At: ${TimeFormat.getMessageTime(context: context, time: widget.messageModel.sent)}', onTap: () {},),

            // Read Time
            OptionItem(
              icon: const Icon(Icons.remove_red_eye,color: Colors.red,), 
              iconName: widget.messageModel.read.isEmpty ? 'Read At: Not Seen Yet' :
              'Read Time:${TimeFormat.getMessageTime(context: context, time: widget.messageModel.read,)}', onTap: () {},),
          ],
        );
      },
    );
  }

  void showMessageUpdateDialoge() {
    String updatedMsg = widget.messageModel.msg;

    showDialog(context: context, builder: (_)=>AlertDialog(
      contentPadding: const EdgeInsets.only(
          left: 24, right: 24, top: 20, bottom: 10),

      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)),

      //title
      title: const Row(
        children: [
          Icon(
            Icons.message,
            color: kPrimaryColor,
            size: 28,
          ),
          Text(' Update Message')
        ],
      ),

      //content
      content: TextFormField(
        initialValue: updatedMsg,
        maxLines: null,
        onChanged: (value) => updatedMsg = value,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15))),
      ),

      //actions
      actions: [
        //cancel button
        MaterialButton(
            onPressed: () {
              //hide alert dialog
              Navigator.pop(context);
            },
            child: const Text(
              'Cancel',
              style: TextStyle(color: kPrimaryColor, fontSize: 16),
            )),

        //update button
        MaterialButton(
            onPressed: () {
              //hide alert dialog
              Navigator.pop(context);
              Api.updateMessage(widget.messageModel, updatedMsg);
            },
            child: const Text(
              'Update',
              style: TextStyle(color: kPrimaryColor, fontSize: 16),
            ))
      ],
    ));

  }
}

class OptionItem extends StatelessWidget {
  final Icon icon;
  final String iconName;
  final VoidCallback onTap;
  const OptionItem({super.key, required this.icon, required this.iconName, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.only(left: 30.0,top: 10,bottom: 15),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 20),
            Flexible(child: Text(iconName,style: const TextStyle(fontSize: 20),))
          ],
        ),
      ) ,
    );
  }
}

