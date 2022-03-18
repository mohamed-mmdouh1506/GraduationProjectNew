import 'dart:developer';
import 'package:final_project/models/chatModel/controller/controller.dart';
import 'package:final_project/models/chatModel/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  String? roomName;

  ChatScreen({this.roomName});

  @override
  _ChatScreenState createState() => _ChatScreenState(roomName: roomName);
}

class _ChatScreenState extends State<ChatScreen> {
  String? roomName;

  _ChatScreenState({this.roomName});
  var messageController = TextEditingController();

  ChatController chatController = ChatController();

  late IO.Socket socket;

  @override
  void initState() {
    socket = IO.io(
        'http://localhost:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());

    socket.connect();
    setUpSocketListener();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            const SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  roomName!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                  ),
                ),
                // const Text(
                //   'Status',
                //   style: TextStyle(
                //     color: Colors.white,
                //     fontSize: 12.0,
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: Obx(
                  () => ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var currentIndex = chatController.chat_message[index];
                  return myMessageItem(currentIndex.sentByMe == socket.id,
                      currentIndex.message!);
                },
                itemCount: chatController.chat_message.length,
              ),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.0,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Type a message here....',
                        hintStyle: TextStyle(
                          fontSize: 15
                        ),
                        border: InputBorder.none,
                      ),
                      controller: messageController,
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(left: 5),
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    color: Colors.lightBlue,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: IconButton(
                    onPressed: () {
                      messageFunction(messageController.text);
                      messageController.text = '';
                    },
                    icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 28,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messageItem() {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
          ),
          child: const Text(
            'receved message',
            style: TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget myMessageItem(bool sentByMe, String message) {
    print(sentByMe);
    return Align(
      alignment: sentByMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: BoxDecoration(
            color: sentByMe ? Colors.lightBlue : Colors.lightGreen,
            borderRadius: const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  void messageFunction(String text) {
    var messageJson = {
      "message": text,
      'sentByMe': socket.id,
      'roomName': roomName
    };

    socket.emit('message', messageJson);
    chatController.chat_message.add(Message.fromJson(messageJson));
  }

  void setUpSocketListener() {
    socket.on('message-receive', (data) {
      print(data);
      chatController.chat_message.add(Message.fromJson(data));
    });
  }
}
