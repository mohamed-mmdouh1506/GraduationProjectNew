import 'package:bloc/bloc.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/modules/login/login_screen.dart';
import 'package:final_project/modules/register/registercubit/states.dart';
import 'package:final_project/modules/register/studentRegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class RegisterCubit extends Cubit<RegisterStates>{
  RegisterCubit() : super(InitialState());

  static RegisterCubit get(context) => BlocProvider.of(context);

  TextEditingController? emailController;
  TextEditingController? passController;
  TextEditingController? nameController;
  TextEditingController? conPassController;

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

}