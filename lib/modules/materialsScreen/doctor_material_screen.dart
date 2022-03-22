import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/Contants/contant_screen.dart';
import 'package:final_project/modules/materialsScreen/materials_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';


class DoctorMaterialScreen extends StatelessWidget {
  DoctorMaterialScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){

      },

      builder: (context,index){
        return Scaffold(
          backgroundColor: Colors.white,
          body:  SafeArea(
            child: Container(
              child: Stack(
                children: [
                  Positioned(
                    top: 0,
                    left: 10,
                    child: Container(
                      margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
                      padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(11, 24, 82, .9),
                        borderRadius: BorderRadius.circular(20),

                      ),
                      height: 210,
                      width: MediaQuery.of(context).size.width*.9,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children:  [
                          CircleAvatar(
                            radius: 43,
                            backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 40,
                              backgroundImage: NetworkImage(
                                  '${AppCubit.get(context).userModel!.image}'
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Text('${AppCubit.get(context).userModel!.fullName}',style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                          ),
                          const SizedBox(height: 10,),
                          Text('${AppCubit.get(context).userModel!.bio}',style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                            textAlign: TextAlign.center,
                          ),

                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    right: 20,
                    top: MediaQuery.of(context).size.height*.34,
                    child: Material(
                      elevation: 3,
                      shadowColor: mainColorLight,
                      borderRadius: BorderRadius.circular(25),
                      child: CircleAvatar(
                        backgroundColor: mainColorButton,
                        radius: 23,
                        child: IconButton(
                          onPressed: (){
                            AppCubit.get(context).getDoctorMaterialTitles().then((value) {
                              navigateTo(context, MaterialsScreen()).then((value) {
                              });
                            });


                          },
                          icon: const Icon(
                            Icons.done,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .54,
                    left: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'What is your grade ?',
                          style: TextStyle(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0 ,),
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: DropdownButton(
                              dropdownColor: Colors.grey[300],
                              elevation: 0,
                              hint: AppCubit.get(context).gradeDropMenu.isEmpty?const Text('Grade', style: TextStyle(color: Colors.black, fontSize: 16.0 , fontWeight: FontWeight.bold),):
                              Text(AppCubit.get(context).gradeDropMenu, style: const TextStyle(color: Colors.black, fontSize: 16.0 , fontWeight: FontWeight.bold)),
                              isExpanded: true,
                              iconSize: 30.0,
                              style: const TextStyle(color: Colors.black , fontSize: 16.0 , fontWeight: FontWeight.bold),
                              items: ['First', 'Second', 'Third' , 'Fourth'].map(
                                    (value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                AppCubit.get(context).setGradeDrop(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    top: MediaQuery.of(context).size.height * .40,
                    left: 22,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'What is your Department ?',
                          style: GoogleFonts.nunitoSans(
                            color: Colors.black87,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5.0 ,),
                          height: MediaQuery.of(context).size.height * 0.07,
                          width: MediaQuery.of(context).size.width * 0.7,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            border: Border.all(
                              color: Colors.black,
                              width: 1,
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            child: DropdownButton(
                              elevation: 0,
                              hint: AppCubit.get(context).departmentDropMenu.isEmpty?const Text(
                                'Department',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ):Text(AppCubit.get(context).departmentDropMenu,
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                              dropdownColor: Colors.grey[300],
                              isExpanded: true,
                              iconSize: 30.0,
                              style: const TextStyle(color: Colors.black , fontSize: 16.0 , fontWeight: FontWeight.bold),
                              items: ['General', 'Security', 'Medical','Network'].map(
                                    (value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                },
                              ).toList(),
                              onChanged: (value) {
                                AppCubit.get(context).setDepartmentDrop(value);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // SizedBox(height: 5,),
                  // Expanded(
                  //   child: GridView.count(
                  //     crossAxisCount: 2,
                  //     physics: const BouncingScrollPhysics(),
                  //     crossAxisSpacing: 0,
                  //     mainAxisSpacing: 0,
                  //     childAspectRatio: 1/.8,
                  //     children: List.generate(colorsContainer.length, (index) =>Block_Materials(texts[index], colorsContainer[index], colorsItem[index],context) ),
                  //
                  //
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        );

      },

    );
  }
}
