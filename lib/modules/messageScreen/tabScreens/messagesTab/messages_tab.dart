import 'package:final_project/constants/componts.dart';
import 'package:final_project/modules/chatScreen/chat_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessagesTab extends StatelessWidget {
  const MessagesTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*0.01,
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.15,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context , index)=> storyItem(),
              separatorBuilder: (context , index)=> const SizedBox(width: 10.0,),
              itemCount: 10,
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height*0.01,
          ),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context , index)=> messageRowItem(context),
              separatorBuilder: (context , index)=> const SizedBox(
                height: 10.0,
              ),
              itemCount: 20,
          ),
        ],
      ),
    );
  }

  Widget storyItem ()
  {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5.0),
          child: Stack(
            alignment: AlignmentDirectional.bottomEnd,
            children: [
              Stack(
                alignment: AlignmentDirectional.center,
                children: const [
                  CircleAvatar(
                    backgroundColor: Colors.lightBlue,
                    radius: 35.0,
                  ),
                  CircleAvatar(
                    backgroundImage: AssetImage('assets/images/profile.png'),
                    radius: 33.0,
                  ),
                ],

              ),
              Padding(
                padding: const EdgeInsets.all(3.0),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: const[
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 11.0,
                    ),
                    CircleAvatar(
                      backgroundColor: Colors.amber,
                      radius: 9.0,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Text(
          'Mohamed',
          style: TextStyle(
            fontSize: 16.0,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  Widget messageRowItem(context)
  {
    return InkWell(
      onTap: (){
        navigateTo(context, ChatScreen(roomName: 'Mohamed Mmdouh',));
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Stack(
                    alignment: AlignmentDirectional.center,
                    children: const [
                      CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        radius: 30.0,
                      ),
                      CircleAvatar(
                        backgroundImage: AssetImage('assets/images/profile.png'),
                        radius: 28.0,
                      ),
                    ],

                  ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Stack(
                      alignment: AlignmentDirectional.center,
                      children: const[
                        CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 9.0,
                        ),
                        CircleAvatar(
                          backgroundColor: Colors.amber,
                          radius: 7.0,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Mohamed Mmdouh',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 0.2,
                  ),
                  Text(
                    'Hello , this is Message Screen',
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Text(
                  '3m ago',
                  style: TextStyle(
                    fontSize: 15.0,

                  ),
                ),
                SizedBox(
                  height: 2.0,
                ),
                Text(
                  'status',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

}
