import 'package:final_project/models/userModel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../models/SingleChat/MessageModel.dart';

class SingleChat extends StatefulWidget {
  final UserModel sourceModel;
  final UserModel receiverModel;
  const SingleChat({Key? key , required this.sourceModel , required this.receiverModel}) : super(key: key);

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  IO.Socket? socket;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<MessageModel> messages = [];

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.1.12:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    },);
    socket!.connect();
    socket!.emit("signin", widget.sourceModel.uId);

    socket!.onConnect((data) {
      print("Connected");
      socket!.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });
    });
    print(socket!.connected);
  }

  void sendMessage(String message, String sourceId, String targetId) {
    setMessage("source", message);
    socket!.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId});
  }

  void setMessage(String type, String message) {
    MessageModel messageModel = MessageModel(
        type: type,
        message: message,
        time: DateTime.now().toString().substring(10, 16));
    print(messages);

    setState(() {
      messages.add(messageModel);
    });
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
                  widget.receiverModel.fullName!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 9,
            child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  if (index == messages.length) {
                    return Container(
                      height: 70,
                    );
                  }
                  if (messages[index].type == "source"){
                    return myMessageItem(messages[index].message!);
                  }
                  else{
                    return messageItem(messages[index].message!);
                  }
                },
              shrinkWrap: true,
              controller: scrollController,
              itemCount: messages.length + 1,
              ),
          ),
          Padding(
               padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
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
                     height: 40,
                     width: 40,
                     decoration: BoxDecoration(
                         color: Colors.lightBlue,
                         borderRadius: BorderRadius.circular(10)
                     ),
                     child: IconButton(
                       onPressed: (){
                         scrollController.animateTo(
                             scrollController.position.maxScrollExtent,
                             duration: const Duration(milliseconds: 300),
                             curve: Curves.easeOut,
                         );
                         sendMessage(
                             messageController.text,
                             widget.sourceModel.uId!,
                             widget.receiverModel.uId!,
                         );
                         messageController.clear();
                       },
                       icon: const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                      size: 22,
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


  Widget messageItem(String message) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: const BoxDecoration(
            color: Colors.lightGreen,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
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

  Widget myMessageItem( String message) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10.0),
          decoration: const BoxDecoration(
            color: Colors.lightBlue,
            borderRadius: BorderRadiusDirectional.only(
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



}
