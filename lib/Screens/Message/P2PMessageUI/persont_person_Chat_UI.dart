import 'package:flutter/material.dart';
import 'package:wechat/Screens/Message/P2PMessageUI/ReceiverUI.dart';
import 'package:wechat/Screens/Message/P2PMessageUI/senderUI.dart';

class P2PUI extends StatefulWidget {
  const P2PUI({super.key});

  @override
  State<P2PUI> createState() => _P2PUIState();
}

class _P2PUIState extends State<P2PUI> {
  @override
  Widget build(BuildContext context) {
    return const Column(
        children: [
          SenderMessageUI(),
          ReceiverMessageUI()

        ],
    );
  }
}
