import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/chatScreen/SingleChat.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../../../layoutes/homepage/home_bloc/app_cubit.dart';
import '../../../../models/userModel/user_model.dart';

class FriendsTab extends StatelessWidget {
  const FriendsTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <AppCubit , AppState>(
      listener: (context , state){},
      builder: (context , state){
        var friends = AppCubit.get(context).userFriends;

        return  Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: ListView.separated(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context , index)=> messageRowItem(friends[index] , context),
            separatorBuilder: (context , index)=> const SizedBox(
              height: 10.0,
            ),
            itemCount: friends.length,
          ),
        );
      },
    );
  }

  Widget messageRowItem(UserModel model , context)
  {
    return InkWell(
      onTap: (){
        navigateTo(context, SingleChat(sourceModel: AppCubit.get(context).userModel!, receiverModel: model));
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
                    children:  [
                      const CircleAvatar(
                        backgroundColor: Colors.lightBlue,
                        radius: 30.0,
                      ),
                      CircleAvatar(
                        backgroundImage: NetworkImage('${model.image}'),
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
                children: [
                  Text(
                    '${model.fullName}',
                    style: GoogleFonts.lato(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Text(
                    '${DateFormat('EEE, d MMM y     hh:mm aaa').format(DateTime.now())}',
                    style: const TextStyle(
                      fontSize: 14.0,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.call,
                  size: 25.0,
                  color: Colors.lightBlue,
                ),
            ),
          ],
        ),
      ),
    );
  }

}