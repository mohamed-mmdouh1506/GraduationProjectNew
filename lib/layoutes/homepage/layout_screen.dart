import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/NewPost/NewPost.dart';
import 'package:final_project/modules/SearchScreen/SearchScreen.dart';
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
                  appBar: appBar(AppBar().preferredSize.height , context),
                  body: cubit.doctorCheck==null? const Center(child: CircularProgressIndicator(),): cubit.doctorCheck!?cubit.doctorScreens[cubit.currentIndex]:cubit.studentScreens[cubit.currentIndex],
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


  appBar(height , context ) => PreferredSize(
    preferredSize:  Size(MediaQuery.of(context).size.width, height+60 ),
    child: Stack(
      children: <Widget>[
        Container(
          child: Center(
            child: Text(
              "BFCAI Community",
              style: GoogleFonts.lato(
                fontSize: 25.0,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ),
          color: mainColorLayout,
          height: height+70,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          top: 92.0,
          left: 20.0,
          right: 20.0,
          child: Material(
            borderRadius: BorderRadius.circular(15.0),
            elevation: 2,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  InkWell(
                    onTap: (){
                      AppCubit.get(context).doSmallScreen();
                    },
                    child: Icon(Icons.menu, color: mainColorLayout,),
                  ),
                  const SizedBox(
                    width: 12.0,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: (){
                        navigateTo(context, const SearchScreen());
                      },
                      child: Text(
                        'Search',
                        style: GoogleFonts.lato(
                          color: Colors.grey,
                          fontSize: 16.0,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.search, color: mainColorLayout),
                    onPressed: () {
                      navigateTo(context, const SearchScreen());
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.notifications, color: mainColorLayout),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(),
      ],
    ),
  );


}

