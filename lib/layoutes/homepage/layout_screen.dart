import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LayoutScreen extends StatelessWidget {
  const LayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            backgroundColor: Colors.grey[200],
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
                        radius: 10,
                        backgroundImage: AssetImage('assets/images/mine.png'),
                      ),
                  ),
                ),
              ),

              title:  Container(
                margin: EdgeInsets.fromLTRB(0, 7, 0, 0),
                width: 230,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
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
                Container(
                  margin: const EdgeInsets.fromLTRB(0, 8, 10, 0),
                  child: const Image(
                    height: 25,
                    width: 25,
                    image: AssetImage(
                      'assets/images/chat.png'
                    ),
                  )
                ),

              ],
            ),
              body: cubit.Screens[cubit.currentIndex],
              bottomNavigationBar: ConvexAppBar(
                backgroundColor: Colors.blue,
                items: [
                  TabItem(
                    icon: Icon(Icons.home,size: 25,color: Colors.grey[300],),
                    title: 'Home',
                    activeIcon: const Icon(Icons.home,size: 32,color: Colors.blue,),
                  ),
                  TabItem(
                    icon: Icon(Icons.group,size: 25,color: Colors.grey[300],),
                    title: 'Groups',
                    activeIcon: const Icon(Icons.group,size: 32,color: Colors.blue,),
                  ),
                  TabItem(
                    icon: Icon(Icons.add,size: 25,color: Colors.grey[300],),
                    title: 'Add Post',
                    activeIcon: const Icon(Icons.add,size: 32,color: Colors.blue,),
                  ),
                  TabItem(
                    icon: Icon(Icons.menu_book,size: 25,color: Colors.grey[300],),
                    title: 'Materials',
                    activeIcon: const Icon(Icons.menu_book,size: 32,color: Colors.blue,),
                  ),
                  TabItem(
                    icon: Icon(Icons.settings,size: 25,color: Colors.grey[300],),
                    title: 'Settings',
                    activeIcon: const Icon(Icons.settings,size: 25,color: Colors.blue,),
                  ),
                ],
                initialActiveIndex: cubit.currentIndex,
                onTap: (int i) {
                  cubit.changeBottomNavigate(i);
                },
              )
          ),



        );
      },
    );
  }
}

