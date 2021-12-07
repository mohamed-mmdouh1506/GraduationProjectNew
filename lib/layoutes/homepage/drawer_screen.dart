import 'package:final_project/constants/componts.dart';
import 'package:final_project/modules/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class itemModel {
  String? text;
  IconData? icon;
  Function? function;

  itemModel({
    required this.text,
    required this.icon,
    required this.function,
  });
}


class DrawerScreen extends StatelessWidget {
  DrawerScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    List drawerItems = [
      itemModel(
          text: 'Profile',
          icon: Icons.person,
          function: () {
            navigateTo(context, Profile());
          }),

      itemModel(
          text: 'Materials',
          icon:Icons.menu,
          function: () {
            print('Materials');
          }),

      itemModel(
          text: 'Groups',
          icon: Icons.group_add_outlined,
          function: () {
            print('Groups');
          }),

      itemModel(
          text: 'Chats',
          icon:Icons.chat,
          function: () {
            print('Chats');
          }),

      itemModel(
          text: 'Settings and Privacy',
          icon: Icons.settings,
          function: () {
            print('Settings and Privacy');
          }),

      itemModel(
          text: 'Log out',
          icon: Icons.logout,
          function: () {
            print('Log out');
          }),
    ];



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
                    const CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/images/mine.png'),
                      ),
                    ),
                    SizedBox(width: 10,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Mahmoud Reda',
                            style: GoogleFonts.lato(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold)
                        ),
                        SizedBox(height: 7,),

                        Text('Third , Computer Science',
                            style: GoogleFonts.lato(
                              color: Colors.white,
                              fontSize: 13,
                            )),
                        const SizedBox(
                          height: 15,
                        ),
                      ],
                    )
                  ],
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   children: [
                //     Text('114 ',
                //         style: GoogleFonts.lato(
                //             color: Colors.black,
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold)),
                //     const SizedBox(
                //       width: 3,
                //     ),
                //     Text('Following',
                //         style: GoogleFonts.lato(
                //           color: Colors.blueGrey,
                //           fontSize: 15,
                //         )),
                //     const SizedBox(
                //       width: 15,
                //     ),
                //     Text('334',
                //         style: GoogleFonts.lato(
                //             color: Colors.black,
                //             fontSize: 15,
                //             fontWeight: FontWeight.bold)),
                //     const SizedBox(
                //       width: 3,
                //     ),
                //     Text('Followers',
                //         style: GoogleFonts.lato(
                //           color: Colors.blueGrey,
                //           fontSize: 15,
                //         )),
                //   ],
                // ),
              ],
            ),
          ),
          Column(
            children: [
              // const SizedBox(
              //   height: 25,
              // ),
              // Container(
              //   height: 1,
              //   width: double.infinity,
              //   color: Colors.grey,
              // ),
              // const SizedBox(
              //   height: 7,
              // ),
              // Container(
              //   height: 1,
              //   width: double.infinity,
              //   color: Colors.grey,
              // ),
              SizedBox(height: 80,),
              Container(
                height:350,
                child: ListView.separated(
                    itemBuilder: (context,index)=> drawerBlock(drawerItems[index]),
                    separatorBuilder: (context,index){
                      return const SizedBox(height: 30,);
                    },
                    itemCount: drawerItems.length
                ),
              ),
              // const SizedBox(height: 40,),
              // Container(
              //   height: 1,
              //   width: double.infinity,
              //   color: Colors.grey,
              // ),
              SizedBox(height: 110,),
              Padding(
                padding: const EdgeInsets.fromLTRB(17, 15, 17, 0),
                child: Row(
                  children: [
                    Text('Help Center',style: GoogleFonts.lato(
                        fontSize: 15,
                        color: Colors.white
                    ),),
                    const Spacer(),
                    Container(
                        height: 25,
                        width: 25,
                        child: const Image(image: AssetImage('assets/images/idea.png')
                        )),

                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

Widget drawerBlock(itemModel model){

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
          Text('${model.text}',style: GoogleFonts.lato(
              fontSize: 15,
              color: Colors.white

          ),),


        ],
      ),
    ),
  );

}