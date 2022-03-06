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

  List <String> texts =[
    'Image Processing',
    'Compiler',
    'Network',
    'Simulation',
    'NLP',
  ];

  List <Color> colorsContainer =[
    const Color.fromRGBO(253, 242, 209, 1.0),
    const Color.fromRGBO(195, 198, 252, 0.7647058823529411),
    const Color.fromRGBO(253, 198, 208, 1.0),
    const Color.fromRGBO(199, 255, 241, 1.0),
    const Color.fromRGBO(241, 198, 253, 1.0),
  ];

  List <Color> colorsItem =[
    Colors.amber,
    Colors.blueAccent,
    const Color.fromRGBO(255, 13, 60, 1.0),
    const Color.fromRGBO(0, 199, 205, 1.0),
    const Color.fromRGBO(211, 13, 255, 1.0),
  ];

  @override
  Widget build(BuildContext context) {
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
                          Text('My Courses',style: GoogleFonts.lato(
                            color:Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 22,
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
                      children: List.generate(colorsContainer.length, (index) =>Block_Materials(texts[index], colorsContainer[index], colorsItem[index],context) ),
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
}

Widget Block_Materials(String text,Color colorContainer,Color colorItem,context){
  return InkWell(
    onTap: (){
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
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
              child: Text(
                text,
                style: GoogleFonts.openSans(
                color: colorItem,
                fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}
