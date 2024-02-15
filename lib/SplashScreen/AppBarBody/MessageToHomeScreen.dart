import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:toast/toast.dart';
import 'package:wechat/Api/Api.dart';
import 'package:wechat/Screens/profile_screen.dart';
import 'package:wechat/SplashScreen/AppBarBody/MessageHomeScreenListDesign.dart';
import 'package:wechat/Themes/constants.dart';
import 'package:wechat/dialoge_box/snackBar.dart';

import '../../Model/chatUserModel.dart';

// ***************************************Main Chats List will be done here******************************************

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ChatUserModel> list = [];
  final List<ChatUserModel> _searchList = [];
  bool _isSearching = false;

  @override
  void initState() {
    super.initState();
    Api.getSelfInfo();

    SystemChannels.lifecycle.setMessageHandler(
      (message) {
        if (Api.auth.currentUser != null) {
          if (message.toString().contains('resume')) {
            Api.updateActiveStatus(true);
          }
          if (message.toString().contains('pause')) {
            Api.updateActiveStatus(false);
          }
        }

        return Future.value(message);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: _isSearching ? 35 : 100,
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: kPrimaryColor),
          backgroundColor: kPrimaryColor,
          title: _isSearching
              ? Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: TextField(
                    style: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w700),
                    autofocus: true,
                    decoration: const InputDecoration(
                      hintText: "Search Name",
                      border: InputBorder.none,
                      alignLabelWithHint: true,
                    ),
                    onChanged: (value) {
                      _searchList.clear();
                      for (var i in list) {
                        if (i.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            i.email
                                .toLowerCase()
                                .contains(value.toLowerCase())) {
                          _searchList.add(i);
                        }
                      }
                      setState(() {
                        _searchList;
                      });
                    },
                  ),
                )
              : const Text("WeChat",
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700)),
          bottom: PreferredSize(
              preferredSize: _isSearching
                  ? const Size.fromHeight(35.0)
                  : const Size.fromHeight(15.0),
              child: Column(
                children: [
                  Padding(
                      padding: _isSearching
                          ? EdgeInsets.zero
                          : const EdgeInsets.only(left: 14, bottom: 8),
                      child: _isSearching
                          ? const Text("")
                          : const Row(
                              children: [
                                Text("Messages",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 30)),
                              ],
                            ))
                ],
              )),
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {
                    _isSearching = !_isSearching;
                  });
                },
                icon: Icon(_isSearching ? Icons.clear : Icons.search),
                padding: _isSearching
                    ? const EdgeInsets.only(top: 12)
                    : EdgeInsets.zero),
            _isSearching
                ? const SizedBox()
                : IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ProfileScreen(chatUserModel: Api.me),
                          ));
                    },
                    icon: const Icon(Icons.person_2_rounded),
                    padding: _isSearching
                        ? const EdgeInsets.only(top: 12)
                        : EdgeInsets.zero)
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 20.0, right: 10),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.bottomRight,
                  child: FloatingActionButton(
                    onPressed: () {
                      addNewUserDialoge();
                    },
                    backgroundColor: kPrimaryColor,
                    child: const Icon(Icons.person_add_alt_1_sharp),
                  )),
            ],
          ),
        ),
        body: StreamBuilder(
          stream: Api.getAllMyUsers(),
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
              case ConnectionState.none:
                return const Center(child: CircularProgressIndicator());

              case ConnectionState.active:
              case ConnectionState.done:
                return StreamBuilder(
                  stream: Api.getAllUser(snapshot.data?.docs
                          .map((e) => e.id)
                          .toList() ?? []), //the user name should be same as firestore  database collection check that again
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                      case ConnectionState.none:


                      case ConnectionState.active:
                      case ConnectionState.done:
                          final data = snapshot.data?.docs;
                          list = data
                                  ?.map((e) => ChatUserModel.fromJson(e.data()))
                                  .toList() ??
                              [];
                        if (list.isNotEmpty) {
                          return ListView.builder(
                            padding: const EdgeInsets.only(top: 15),
                            physics: const BouncingScrollPhysics(),
                            itemCount:
                                _isSearching ? _searchList.length : list.length,
                            itemBuilder: (context, index) {
                              return HomeListDesign(
                                userModel: _isSearching
                                    ? _searchList[index]
                                    : list[index],
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: Text(
                            'No Connection Found',
                            style: TextStyle(fontSize: 20),
                          ));
                        }
                    }
                  },
                );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ));
  }

  void addNewUserDialoge() {
    String email = '';

    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              contentPadding: const EdgeInsets.only(
                  left: 24, right: 24, top: 20, bottom: 10),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),

              //title
              title: const Row(
                children: [
                  Icon(
                    Icons.person,
                    color: kPrimaryColor,
                    size: 28,
                  ),
                  Text('Add User')
                ],
              ),

              //content
              content: TextFormField(
                maxLines: null,
                onChanged: (value) => email = value,
                decoration: InputDecoration(
                    hintText: 'Email-Id',
                    prefixIcon: const Icon(Icons.email, color: kPrimaryColor),
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
                    onPressed: () async {
                      //hide alert dialog
                      Navigator.pop(context);
                      if (email.isNotEmpty) {
                        await Api.addChatUser(email).then(
                          (value) {
                            if (!value) {
                              // Fluttertoast.showToast(msg: "User Does Not Exist",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 1,
                              //     backgroundColor: Colors.red,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0
                              // );
                              SnackBar1.showFloatingSnackBar(
                                  context, "No User Found");
                            }
                          },
                        );
                      }
                    },
                    child: const Text(
                      'Add',
                      style: TextStyle(color: kPrimaryColor, fontSize: 16),
                    ))
              ],
            ));
  }
}
