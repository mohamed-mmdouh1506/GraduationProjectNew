import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
   ChatScreen({Key? key}) : super(key: key);
   var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: Colors.blue,
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(
              width: 15.0,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Mohamed Mmdouh',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.w900,
                    height: 1.3,
                  ),
                ),
                Text(
                  'Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12.0,
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
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context , index){
                  return myMessageItem();
              },
              separatorBuilder: (context , index) => const SizedBox(
                height: 1.0,
              ),
              itemCount: 0,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0 , vertical: 15.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 40.0,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.grey[200],
                    ),
                    child: TextField(
                      decoration: const InputDecoration(
                        hintText: 'Type a message here....',
                        border: InputBorder.none,
                      ),
                      controller: messageController,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: (){},
                  icon: const Icon(
                    Icons.send_rounded,
                    color: Colors.blue,
                    size: 35,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget messageItem()
  {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 10.0),
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

  Widget myMessageItem()
  {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 10.0),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadiusDirectional.only(
              topStart: Radius.circular(10.0),
              topEnd: Radius.circular(10.0),
              bottomStart: Radius.circular(10.0),
            ),
          ),
          child: const Text(
            'sended message',
            style: TextStyle(
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
