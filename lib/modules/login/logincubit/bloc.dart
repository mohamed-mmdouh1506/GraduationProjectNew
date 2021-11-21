import 'package:bloc/bloc.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/modules/login/logincubit/states.dart';
import 'package:final_project/modules/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  TextEditingController? emailController;
  TextEditingController? passController;
  var loginKey = GlobalKey<FormState>();

  var height=70.0;
  void formValidate(context){
    height=(MediaQuery.of(context).size.height*.115);
    if(loginKey.currentState!.validate()){
       navigateAndFinish(context, const RegisterScreen());
    }
    emit(ValidateState());
  }

  bool showPass=true;
  void showPassword(){
    showPass=!showPass;
    emit(ShowPasswordState());

  }

}