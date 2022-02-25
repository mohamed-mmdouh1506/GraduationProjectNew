import 'package:final_project/constants/constants.dart';
import 'package:final_project/models/homeModel/home_model.dart';
import 'package:final_project/modules/addPost/add_post.dart';
import 'package:final_project/modules/groupsScreen/group_screen.dart';
import 'package:final_project/modules/homeScreen/home_screen.dart';
import 'package:final_project/modules/materialsScreen/doctor_material_screen.dart';
import 'package:final_project/modules/materialsScreen/student_material_screen.dart';
import 'package:final_project/modules/settings/setting_screen.dart';
import 'package:final_project/shared/local/diohelper.dart';
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



  int ?dataLen;
  HomeModel ?homeModel;
  
  List <HomeModel> Posts=[];

  Future  getHomePosts()async{

    await DioHelper.getDate(url: 'homes?populate=*').then((value) {

      homeModel=HomeModel.fromJson(value.data);
      print(homeModel?.data[2].attributes?.image?.images[0].attributes?.url);

      String ?url= homeModel?.data[2].attributes?.image?.images[0].attributes?.url;
      String ?image=mainUrl! + url!;

      dataLen=homeModel?.data.length;
      emit(GetHomePostSuccessState());


    }).catchError((error){
      print('Error in getHome Posts is ${error.toString()}');
      emit(GetHomePostErrorState());

    });


  }


  List material1 = [];

  void getMaterial1 ({required String url })
  {
    DioHelper.getDate(url: url , query: {'populate' : '*'})
        .then((value) {
      print('Material1 : ${value.data['data']}' );
      material1 = value.data['data'];
      emit(GetMaterialSuccessState());
    }).catchError((error){
      print('Error when get Material1 : ${error.toString()}');
      emit(GetMaterialErrorState());
    });
  }

  }