import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/Contants/contant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icon.dart';
import 'package:line_icons/line_icons.dart';

class StudentMaterialScreen extends StatelessWidget {
  StudentMaterialScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getMaterialTitles();
        AppCubit.get(context).getMaterial();
        return BlocConsumer <AppCubit , AppState>(
          listener: (context , state){},
          builder: (context , state){
            var cubit = AppCubit.get(context);
            return SafeArea(
              child: Scaffold(
                backgroundColor: Colors.grey.shade100,
                body:  SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Container(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                          padding: const EdgeInsets.fromLTRB(10, 15, 10, 5),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(11, 24, 82, .9),
                            borderRadius: BorderRadius.circular(20),

                          ),
                          height: 200,
                          width: MediaQuery.of(context).size.width*.9,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                              CircleAvatar(
                                radius: 43,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              Text(
                                '${cubit.userModel!.fullName}',
                                style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                '${cubit.userModel!.bio}',
                                style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        Container(
                          padding: const EdgeInsets.fromLTRB(20,0, 10, 10),
                          child: Row(
                            children: [
                              Text('My Courses :',style: GoogleFonts.mada(
                                color:Colors.black,
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                              ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10,),
                        GridView.count(
                          crossAxisCount: 2,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1/.8,
                          children: List.generate(AppCubit.get(context).coursesTitle.length,
                                  (index) =>Block_Materials(
                                      AppCubit.get(context).coursesTitle[index],
                                      AppCubit.get(context).colorsContainer[index],
                                      AppCubit.get(context).colorsItem[index],
                                      context) ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }
    );
  }
}


Widget Block_Materials(String text,Color colorContainer,Color colorItem,context){
  return InkWell(
    onTap: (){
      AppCubit.get(context).courseName=text;
      AppCubit.get(context).getMaterial();
      AppCubit.get(context).getSection();
      navigateTo(context,ContantScreen(materialName: text) );
    },
    child: Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 10),
      decoration:  BoxDecoration(
        color: colorContainer,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Material(
        color: colorContainer,
        borderRadius: BorderRadius.circular(25),
        elevation: 5.0,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(10, 8, 3, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: (){},
                      icon:  Icon(
                        LineIcons.book,
                        color: colorItem,
                        size: 40,
                      )
                  ),
                  Spacer(),
                  IconButton(
                      onPressed: (){
                        navigateTo(context,ContantScreen(materialName: text) );
                      },
                      icon: Icon(
                        LineIcons.arrowCircleRight,
                        color: colorItem,
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Container(
              width: MediaQuery.of(context).size.width*.4,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                child: Text(
                  text,
                  style: GoogleFonts.openSans(
                  color: colorItem,
                  fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
