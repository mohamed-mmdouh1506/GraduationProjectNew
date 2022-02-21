import 'package:bloc/bloc.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/container_screen.dart';
import 'package:final_project/models/loginModel/login_model.dart';
import 'package:final_project/modules/login/logincubit/states.dart';
import 'package:final_project/modules/register/register_screen.dart';
import 'package:final_project/shared/local/diohelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginCubit extends Cubit<LoginStates>{

  LoginCubit() : super(InitialState());

  static LoginCubit get(context) => BlocProvider.of(context);

  var emailController=TextEditingController();
  var passController=TextEditingController();
  var loginKey = GlobalKey<FormState>();

  var height=70.0;
  void formValidate(context){
    height=(MediaQuery.of(context).size.height*.115);
    if(loginKey.currentState!.validate()){
      userLogin(email: emailController.text,pass: passController.text,context: context);
    }
    emit(ValidateState());
  }

  bool showPass=true;
  void showPassword(){
    showPass=!showPass;
    emit(ShowPasswordState());

  }

  LoginModel ?Model;

  void userLogin({
    required String email,
    required String pass,
    context,
   })
  {
    DioHelper.postDate(url: 'auth/local/', data: {

        "identifier": email,
        "password": pass

    }).then((value) {
      Model=LoginModel.formJson(value.data);
      print(value.statusMessage);
      customToast('Login Success', Colors.green);
      navigateTo(context, ContainerScreen());
      emit(UserLoginSuccessState());
    }).catchError((error){
      print('Account and Password ');
      customToast('Check Your Account or Password', Colors.red);

      print('Error in Login is ${error.toString()}');
      emit(UserLoginErrorState());
    });
  }

}