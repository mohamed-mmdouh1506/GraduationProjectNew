import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/Contants/contant_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class MaterialsScreen extends StatelessWidget {
  const MaterialsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){

      },
      builder: (context,state){
        return Scaffold(
          appBar: AppBar(
            iconTheme: const IconThemeData(
              color: Colors.black87
            ),
            elevation: 1,
            title: Text(
              'Materials',style: GoogleFonts.lato(
                color: mainColorDark,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
            ),
            centerTitle: true,
          ),
          body: AppCubit.get(context).coursesDoctorTitle.isEmpty?
          const Center(child: CircularProgressIndicator(),):
          Container(
            child: GridView.count(
              physics:const BouncingScrollPhysics(),
              crossAxisCount:2,
              childAspectRatio: 1/.8,
              children: List.generate(AppCubit.get(context).coursesDoctorTitle.length,
                      (index) => Block_Materials(AppCubit.get(context).coursesDoctorTitle[index],
                      AppCubit.get(context).colorsContainer[index],
                      AppCubit.get(context).colorsItem[index],
                      context
                  )
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
      AppCubit.get(context).courseName=text;
      navigateTo(context, ContantScreen(materialName: text,));
      AppCubit.get(context).getDoctorMaterial();
      AppCubit.get(context).getDoctorSection();

    },
    child: Container(
      margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration:  BoxDecoration(
        color: colorContainer,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Material(
        elevation: 5,
        borderRadius: BorderRadius.circular(25),
        color: colorContainer,
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
                      },
                      icon: Icon(
                        LineIcons.plus,
                        size: 25,
                        color: colorItem,
                      )
                  ),
                ],
              ),
            ),
            SizedBox(height: 15,),
            Padding(
              padding: const EdgeInsets.fromLTRB(13, 0, 0, 0),
              child: Text(text,style: GoogleFonts.lato(
                  color: colorItem,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),),
            )
          ],
        ),
      ),
    ),
  );
}
