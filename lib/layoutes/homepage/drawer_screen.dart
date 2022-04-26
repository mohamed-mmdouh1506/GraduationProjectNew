import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/BotScreen/BotScreen.dart';
import 'package:final_project/modules/analysisScreen/analysis_screen.dart';
import 'package:final_project/modules/messageScreen/message_screen.dart';
import 'package:final_project/modules/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class ItemModel {
  String? text;
  IconData? icon;
  Function? function;

  ItemModel({
    required this.text,
    required this.icon,
    required this.function,
  });
}


class DrawerScreen extends StatelessWidget {
  const DrawerScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List drawerItems = [
      ItemModel(
          text: 'Profile',
          icon: Icons.person,
          function: () {
            navigateTo(context, const ProfileScreen());
          }),

      ItemModel(
          text: 'Analysis',
          icon:Icons.analytics,
          function: () {
            navigateTo(context, const AnalysisScreen());
          }),

      ItemModel(
          text: 'Groups',
          icon: Icons.group_add_outlined,
          function: () {
            print('Groups');
          }),

      ItemModel(
          text: 'Call us ',
          icon: Icons.smart_toy_outlined,
          function: () {
            navigateTo(context, BotScreen());
          }),

      ItemModel(
          text: 'Chats',
          icon:Icons.chat,
          function: () {
            navigateTo(context, const MessageScreen());
          }),

      ItemModel(
          text: 'Settings and Privacy',
          icon: Icons.settings,
          function: () {
            print('Settings and Privacy');
          }),

      ItemModel(
          text: 'Log out',
          icon: Icons.logout,
          function: () {
            print('Log out');
          }),
    ];

    return Builder(
      builder: (context){
        return BlocConsumer<AppCubit,AppState>(
          listener: (context,state){},
          builder:(context,state) {
            var cubit = AppCubit.get(context);
            return Container(
              color: Colors.blueAccent,
              height: double.infinity,
              padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 17),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10,),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              radius: 27,
                              backgroundColor: Colors.white,
                              child: InkWell(
                                onTap: (){
                                  AppCubit.get(context).doSmallScreen();
                                },
                                child: CircleAvatar(
                                  radius: 25,
                                  backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                    '${cubit.userModel!.fullName}',
                                    style: GoogleFonts.lato(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold)
                                ),
                                const SizedBox(height: 7,),
                                Text(
                                    '${cubit.userModel!.bio}',
                                    style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 13,
                                    ),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 80,),
                      SizedBox(
                        height:350,
                        child: ListView.separated(
                            itemBuilder: (context,index)=> drawerBlock(drawerItems[index]),
                            separatorBuilder: (context,index){
                              return const SizedBox(height: 30,);
                            },
                            itemCount: drawerItems.length
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height*.13 ,),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(17, 15, 17, 0),
                        child: Row(
                          children: [
                            Text('Help Center',style: GoogleFonts.lato(
                                fontSize: 15,
                                color: Colors.white
                            ),),
                            const Spacer(),
                            const SizedBox(
                                height: 25,
                                width: 25,
                                child: Image(image: AssetImage('assets/images/idea.png')
                                )),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            );
          },

        );
      },
    );
  }
}

Widget drawerBlock(ItemModel model){

  return InkWell(
    onTap: (){
      model.function!();
    },
    child: Container(
      padding: const EdgeInsets.fromLTRB(17, 0, 17, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children:  [
          Icon(
            model.icon,
            color: Colors.white,
          ),
          const SizedBox(width: 15,),
          Text(
            '${model.text}',
            style: GoogleFonts.lato(
              fontSize: 15,
              color: Colors.white,
            ),
          ),
        ],
      ),
    ),
  );

}