import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../models/userModel/user_model.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getUserFriends();
        return BlocConsumer <AppCubit , AppState> (
          listener: (context, state) {},
          builder: (context, state) {
            var cubit = AppCubit.get(context);
            List <UserModel> friends = cubit.userFriends;
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  'Friends' ,
                  style: GoogleFonts.lato(
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                    fontSize: 24.0,
                  ),
                ),
                leading: IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Column(
                  children: [
                    Expanded(
                      child : ListView.separated(
                        itemBuilder: (context , index) => userItem(friends[index] , context),
                        separatorBuilder: (context , index) => const SizedBox(
                          height: 5.0,
                        ),
                        itemCount: friends.length,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }


  Widget userItem (UserModel model , context)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 5.0),
      child: Container(
        height: 80.0,
        width: MediaQuery.of(context).size.width * 1,
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.0,
              backgroundImage: NetworkImage('${model.image}'),
            ),
            const SizedBox(
              width: 8.0,
            ),
            Text(
              '${model.fullName}' ,
              style: GoogleFonts.lato(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
          ],
        ),
      ),
    );
  }


}
