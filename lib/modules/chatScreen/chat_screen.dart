import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/models/chatModel/controller/controller.dart';
import 'package:final_project/models/chatModel/model/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import '../../layoutes/homepage/home_bloc/app_cubit.dart';

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
  List <dynamic> groupMessages = [];

  late IO.Socket socket;

  @override
  void initState() {
    socket = IO.io("http://localhost:5000", <String, dynamic>{
      "transports": ["websocket"],
      "autoConnect": false,
    },);
    socket.connect();
    setUpSocketListener();
    socket.onConnect((data) {
      print("Connected");
      getGroupMessages(widget.roomName.toString());
      socket.on("get_group_messages" , (data){
        //print("get messages function : ${data['messages'].toString()}");
        groupMessages = data['messages'];
        print('group message : ${groupMessages.toString()}');
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          appBar: AppBar(
            titleSpacing: 0.0,
            backgroundColor: const Color.fromRGBO(11, 24, 82, .9),
            title: Row(
              children: [
                const SizedBox(
                  width: 15.0,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      roomName != null ? roomName! : 'Chat Screen',
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
                child: Obx(
                      () => ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      var currentIndex = chatController.chat_message[index];
                      return myMessageItem(currentIndex.sentByMe == AppCubit.get(context).userModel!.uId, currentIndex.message!);
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
                        height: 45.0,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[200],
                        ),
                        child: TextField(
                          decoration: const InputDecoration(
                            hintText: 'Type a message here...',
                            hintStyle: TextStyle(
                                fontSize: 16,
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
                          color: const Color.fromRGBO(11, 24, 82, .9),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: IconButton(
                        onPressed: () {
                          messageFunction(messageController.text , DateFormat('hh:mm aaa').format(DateTime.now()).toString());
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
      },
    );
  }


  Widget myMessageItem(bool sentByMe, String message) {
    print(sentByMe);
    return Align(
      alignment: sentByMe
          ? AlignmentDirectional.centerEnd
          : AlignmentDirectional.centerStart,
      child: Padding(
        padding: sentByMe ? const EdgeInsets.fromLTRB(100, 10, 12, 2) : const EdgeInsets.fromLTRB(12, 10, 100, 2),
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
              const Text(
                'Mohamed Mamdouh',
                style: TextStyle(
                  fontSize: 12.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 2,
              ),
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

  void messageFunction(String text , String time) {
    var messageJson = {
      "message": text,
      'sentByMe': AppCubit.get(context).userModel!.uId,
      'roomName': roomName,
      'time' : time,
    };
    socket.emit('group_message', messageJson);
    chatController.chat_message.add(Message.fromJson(messageJson));
  }

  void getGroupMessages (String roomName) {
    socket.emit("get_group_messages" , {"roomName": roomName, "messages" : []});
  }

  void setUpSocketListener() {
    socket.on('message-receive', (data) {
      print(data);
      print('message receive');
      chatController.chat_message.add(Message.fromJson(data));
    });
  }
}
