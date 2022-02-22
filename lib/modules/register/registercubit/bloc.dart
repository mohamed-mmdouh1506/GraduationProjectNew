import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/container_screen.dart';
import 'package:final_project/models/registerModel/register_model.dart';
import 'package:final_project/modules/login/login_screen.dart';
import 'package:final_project/modules/register/registercubit/states.dart';
import 'package:final_project/modules/register/student_register_screen.dart';
import 'package:final_project/shared/local/cash_helper.dart';
import 'package:final_project/shared/local/diohelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  var emailController=TextEditingController();
  var passController=TextEditingController();
  var usernameController=TextEditingController();
  var conPassController=TextEditingController();
  var startDateController=TextEditingController();
  var setNameController=TextEditingController();
  var setBioController=TextEditingController();

  String? usernameValue=CashHelper.getUserName(key: 'username') ;
  String ?emailValue=CashHelper.getUserName(key: 'email');
  String ?passValue=CashHelper.getUserName(key: 'pass');
  String ?startAtValue=CashHelper.getUserName(key: 'startAt');
  var registerKey = GlobalKey<FormState>();

  var height=70.0;
  Future formValidate(context,widget)async{
    height=(MediaQuery.of(context).size.height*.115);
    if(registerKey.currentState!.validate()){
      navigateTo(context, widget);
      if(widget is LoginScreen){
        userRegister(username: usernameValue!,
            email: emailValue!,
            password: passValue!,
            start_at: startAtValue!,
            grade: 'Fourth',
            depertment: 'Computer Science',
            fullname: setNameController.text,
            bio: setBioController.text
        );
    }

    }
    emit(ValidateState());
  }

  bool showPass=true;

  void showPassword(){
    showPass=!showPass;
    emit(ShowPasswordState());
  }

  bool showConPass=true;

  void showConPassword(){
    showConPass=!showConPass;
    emit(ShowConPasswordState());

  }

  var dropDownValue1 = null;
  var dropDownValue2 = null;

  void changeDropDownValue1 (value)
  {
    dropDownValue1 = value ;
    emit(ChangeDropDownValeState());
  }

  void changeDropDownValue2 (value)
  {
    dropDownValue2 = value ;
    emit(ChangeDropDownValeState());
  }


  File? profileImage;

  ImageProvider profile = const AssetImage('assets/images/profile.png');

  var picker = ImagePicker();

  Future<void> getProfileImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      profile = FileImage(profileImage!);
      print(pickedFile.path);
      emit(UploadProfileImageSuccessState());
    } else {
      print('No Image selected.');
      emit(UploadProfileImageErrorState());
    }
  }


  bool button1 = false ,  button2 = false ,  button3 = false ,
       button4 = false ,  button5 = false,  button6 = false ,
       button7 = false ,  button8 = false;

  void changeButtonState (int key)
  {
    switch (key)
    {
      case 1 :
        button1 != button1;
        emit(ChangeButtonState());
        break;
      case 2 :
        button2 != button2;
        break;
      case 3 :
        button3 != button3;
        break;
      case 4 :
        button4 != button4;
        break;
      case 5 :
        button5 != button5;
        break;
      case 6 :
        button6 != button6;
        break;
      case 7 :
        button7 != button7;
        break;
      case 8 :
        button8 != button8;
        break;
    }
    emit(ChangeButtonState());
  }


  RegisterModel ?Model;

  void userRegister({
    required String username,
    required String email,
    required String password,
    required String start_at,
    required String grade,
    required String depertment,

    String ?image,
    required String fullname,
    required String bio,
    context,
  })
  {
    DioHelper.postDate(url:'auth/local/register', data: {

      "username": username,
      "email": email,
      "password": password,
      "start_at": start_at,
      "grade": grade,
      "depertment": depertment,
      "image":image,
      "bio": bio,
      "fullname": fullname

    }).then((value) {
      Model=RegisterModel.fromJson(value.data);
      print(value.data);
      emit(UserRegisterSuccessState());
    }).catchError((error){

      print('Error in Register is ${error.toString()}');
      emit(UserRegisterErrorState());
    });
  }


}