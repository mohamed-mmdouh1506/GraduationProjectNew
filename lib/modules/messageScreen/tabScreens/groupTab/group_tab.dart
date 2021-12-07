import 'package:final_project/constants/componts.dart';
import 'package:final_project/modules/chatScreen/chat_screen.dart';
import 'package:flutter/material.dart';

class GroupTab extends StatelessWidget {
  const GroupTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> groupNames = [
      'Algorithms',
      'Assembly',
      'Automate',
      'Logic Programming',
      'Numerical Analysis',
      'Software Engineer',
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: ListView.separated(
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context , index)=> messageRowItem(groupNames[index] , context),
        separatorBuilder: (context , index)=> const SizedBox(
          height: 10.0,
        ),
        itemCount: groupNames.length,
      ),
    );
  }

  Widget messageRowItem(String groupName , context)
  {
    return InkWell(
      onTap: (){
        navigateTo(context, ChatScreen());
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
                children:  [
                  Text(
                    groupName,
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 0.2,
                  ),
                  const Text(
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