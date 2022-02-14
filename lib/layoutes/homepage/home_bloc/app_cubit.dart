import 'package:final_project/modules/addPost/add_post.dart';
import 'package:final_project/modules/groupsScreen/group_screen.dart';
import 'package:final_project/modules/homeScreen/home_screen.dart';
import 'package:final_project/modules/materialsScreen/doctor_material_screen.dart';
import 'package:final_project/modules/materialsScreen/student_material_screen.dart';
import 'package:final_project/modules/settings/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppCubit extends Cubit<AppState> {

  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  double xOffcet = 0;
  double yOffcet = 0;
  double scale = 1;
  bool factor = false;

  void doSmallScreen() {
    if (factor == false) {
      xOffcet = 220;
      yOffcet = 120;
      scale = .7;
      factor = true;
      emit(SmallScreenState());
    }
    else{
        xOffcet=0;
        yOffcet=0;
        scale=1;
        factor=false;
        emit(NormalScreenState());
    }
  }

  int  currentIndex=0;

  void changeBottomNavigate(index){
    currentIndex=index;
    emit(ChangeBottomNavigateState());
  }

  List <Widget> Screens =[
    const HomeScreen(),
    const GroupScreen(),
          StudentMaterialScreen(),
    const SettingScreen(),
  ];

  List <String> Titles =[
    'HomeScreen',
    'GroupScreen',
    'MaterialScreen',
    'SettingScreen',
  ];


  }