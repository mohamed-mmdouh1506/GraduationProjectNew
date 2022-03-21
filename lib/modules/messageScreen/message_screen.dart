import 'package:final_project/modules/messageScreen/tabScreens/friendsTab/friends_tab.dart';
import 'package:final_project/modules/messageScreen/tabScreens/groupTab/group_tab.dart';
import 'package:final_project/modules/messageScreen/tabScreens/messagesTab/messages_tab.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Widget> tabScreens = const [
      MessagesTab(),
      GroupTab(),
      FriendsTab(),
    ];

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: const Text(
            'Chats',
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.w900,
            ),
            textAlign: TextAlign.center,
          ),
          actions: [
            IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.person_add,
                  size: 30.0,
                ),
            ),
            IconButton(
              onPressed: (){},
              icon: const Icon(
                Icons.search,
                size: 30.0,
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.03,
            ),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Message',
                  style : TextStyle(
                    fontSize: 16.0,
                    //fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Group',
                  style : TextStyle(
                    fontSize: 16.0,
                    //fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  'Friends',
                  style : TextStyle(
                    fontSize: 16.0,
                    //fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: tabScreens,
        ),
      ),
    );
  }
}
