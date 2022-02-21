import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/modules/login/login_screen.dart';
import 'package:final_project/modules/register/registercubit/states.dart';
import 'package:final_project/modules/register/student_register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController? emailController;
  TextEditingController? passController;
  TextEditingController? usernameController;
  TextEditingController? conPassController;
  TextEditingController? startDateController;
  TextEditingController? setNameController;
  TextEditingController? setBioController;

  var registerKey = GlobalKey<FormState>();

  var height=70.0;
  void formValidate(context){
    height=(MediaQuery.of(context).size.height*.115);
    if(registerKey.currentState!.validate()){
      navigateTo(context, const StudentRegisterScreen());
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



}