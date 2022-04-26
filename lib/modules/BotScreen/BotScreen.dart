import 'package:flutter/material.dart';

class BotScreen extends StatelessWidget {
   BotScreen({Key? key}) : super(key: key);
   var messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        backgroundColor: Colors.blue,
        title: Row(
          children: const [
             CircleAvatar(
              radius: 20.0,
              backgroundImage: AssetImage('assets/images/robot.png'),
            ),
             SizedBox(
              width: 15.0,
            ),
            Text(
              'Call us',
              style: TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.w900,
                height: 1.3,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 14),
              child: Row(
                children: [
                  const CircleAvatar(
                    backgroundImage: AssetImage('assets/images/robot.png'),
                    radius: 28.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0 ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 10.0),
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadiusDirectional.only(
                          topStart: Radius.circular(10.0),
                          topEnd: Radius.circular(10.0),
                          bottomEnd: Radius.circular(10.0),
                        ),
                      ),
                      child: const Text(
                        "Hi , I'm Emad , am here to help you",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
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

  Widget botMessageItem()
  {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10 , vertical: 14),
        child: Row(
          children: [
            const CircleAvatar(
              backgroundImage: AssetImage('assets/images/robot.png'),
              radius: 28.0,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0 ),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 15.0 , vertical: 10.0),
                decoration: const BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadiusDirectional.only(
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
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
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
          decoration: BoxDecoration(
            color: Colors.grey [300],
            borderRadius: const BorderRadiusDirectional.only(
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
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }


}
