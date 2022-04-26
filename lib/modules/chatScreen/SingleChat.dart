import 'package:final_project/models/userModel/user_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:socket_io_client/socket_io_client.dart';

import '../../models/SingleChat/MessageModel.dart';

class SingleChat extends StatefulWidget {
  final UserModel? sourceModel;
  final UserModel? receiverModel;
  const SingleChat({Key? key , this.sourceModel , this.receiverModel}) : super(key: key);

  @override
  State<SingleChat> createState() => _SingleChatState();
}

class _SingleChatState extends State<SingleChat> {
  IO.Socket? socket;
  TextEditingController messageController = TextEditingController();
  ScrollController scrollController = ScrollController();
  List<MessageModel> messages = [];
  List <dynamic> serverMessages = [];

  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    socket = IO.io("http://192.168.1.2:5000",  OptionBuilder()
        .setTransports(['websocket'])
        .build(),
    );

    socket!.connect();
    getMessages(widget.sourceModel!.uId! , widget.receiverModel!.uId!);
    socket!.emit("signin", widget.sourceModel!.uId);

    socket!.onConnect((data) {
      print("Connected");
      socket!.on("message", (msg) {
        print(msg);
        setMessage("destination", msg["message"]);
        scrollController.animateTo(scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 300), curve: Curves.easeOut);
      });

      socket!.on("get_messages" , (data){
        //print("get messages function : ${data['messages'].toString()}");
        serverMessages = data['messages'];
        serverMessages.forEach((element) {
          if(element['sender'] == widget.sourceModel!.uId){
            setMessage("source", element["message"]);
          } else{
            setMessage("destination", element["message"]);
          }
        });
      });
    });
    print(socket!.connected);
  }

  void sendMessage(String message, String sourceId, String targetId , String time) {
    setMessage("source", message);
    socket!.emit("message",
        {"message": message, "sourceId": sourceId, "targetId": targetId , "date" : time});
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

  void getMessages (String sourceId, String targetId) {
    socket!.emit("get_messages" , {"sourceId": sourceId, "targetId": targetId});
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
                  widget.receiverModel!.fullName!,
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
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
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
                    return myMessageItem(true , messages[index].message!);
                  }
                  else{
                    return myMessageItem(false , messages[index].message!);
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
                       height: 45.0,
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
                             widget.sourceModel!.uId!,
                             widget.receiverModel!.uId!,
                             DateFormat('hh:mm aaa').format(DateTime.now()).toString(),
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

  Widget myMessageItem(bool sentByMe, String message) {
    print(sentByMe);
    return Align(
      alignment: sentByMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Padding(
        padding: sentByMe ? const EdgeInsets.fromLTRB(100, 10, 20, 2) : const EdgeInsets.fromLTRB(20, 10, 100, 2),
        child: Container(
          padding: const EdgeInsets.only(right: 10.0, left: 10.0 , top: 5.0 , bottom: 2.0),
          decoration: BoxDecoration(
            color: sentByMe ? const Color.fromRGBO(11, 24, 82, .9) : Colors.lightGreen,
            borderRadius: sentByMe ? const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ) : const BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomEnd: Radius.circular(10.0),
            ),
          ),
          child: Column(
            mainAxisAlignment: sentByMe ? MainAxisAlignment.start : MainAxisAlignment.end,
            crossAxisAlignment: sentByMe ? CrossAxisAlignment.start : CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
              Text(
                DateFormat('hh:mm aaa').format(DateTime.now()).toString(),
                style: const TextStyle(
                  fontSize: 10.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}
