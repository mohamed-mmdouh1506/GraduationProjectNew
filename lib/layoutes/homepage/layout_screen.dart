import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/NewPost/NewPost.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';


class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        AppCubit.get(context).getHomePost();
        return BlocConsumer<AppCubit,AppState>(
          listener: (context,state){},
          builder: (context,state){
            var cubit= AppCubit.get(context);
            return AnimatedContainer(
              height: double.infinity,
              width: double.infinity,
              transform: Matrix4.translationValues(cubit.xOffcet, cubit.yOffcet, 0)..scale(cubit.scale),
              duration: const Duration(milliseconds: 300),
              color: Colors.white,
              child: Scaffold(
                  backgroundColor: Colors.grey.shade100,
                  appBar: AppBar(
                    toolbarHeight: 70,
                    elevation: 3.0,
                    leadingWidth: 60,
                    leading: InkWell(
                      onTap: (){
                        cubit.doSmallScreen();
                      },
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(17,5,0,0),
                        decoration: const BoxDecoration(
                            color: Colors.black,
                            shape: BoxShape.circle
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(0),
                          child: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/mine.png',
                            ),
                          ),
                        ),
                      ),
                    ),
                    title:  Container(
                      margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                      width: 260,
                      height: 40,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        children: [
                          const SizedBox(width: 10,),
                          Icon(
                            Icons.search,color: Colors.grey[500],
                          ),
                          const SizedBox(width: 10,),
                          Text('Search',style: GoogleFonts.lato(
                              fontSize: 15,
                              color: Colors.grey[500]
                          ),)
                        ],
                      ),

                    ),
                    actions: [
                      IconButton(onPressed: (){
                        navigateTo(context, NewPost());
                        },
                        icon: const Icon(
                            Icons.add_box_outlined,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  body: cubit.Screens[cubit.currentIndex],
                  bottomNavigationBar: SalomonBottomBar(
                    onTap: (index){
                      cubit.changeBottomNavigate(index);
                    },
                    currentIndex: cubit.currentIndex,
                    items: [
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.home),
                        title: const Text('Home'),
                        selectedColor:Colors.blue,
                      ),
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.group),
                        title: const Text('Groups'),
                        selectedColor:Colors.blue,
                      ),

                      SalomonBottomBarItem(
                        icon: const Icon(Icons.my_library_books),
                        title: const Text('Materials'),
                        selectedColor:Colors.blue,
                      ),
                      SalomonBottomBarItem(
                        icon: const Icon(Icons.notifications_active),
                        title: const Text('Notifications'),
                        selectedColor:Colors.blue,
                      ),
                    ],
                  )
              ),



            );
          },
        );
      },
    );
  }
}

