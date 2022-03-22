import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/modules/register/registercubit/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';


Widget dafaultFormField(
    {
      required  String ?label,
      String ?hint,
      required  Widget ?icon,
      Widget ?suffixIcon,
      bool password = false,
      required  TextEditingController ?controller,
      required  TextInputType ?textInputType,
      required  String ?textValidator,
      context
    }
    ){

  return TextFormField(
    decoration:  InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black
      ),
      hintText: hint,
      helperStyle: const TextStyle(),
      enabledBorder:  OutlineInputBorder(
        borderSide:  const BorderSide(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      border:  OutlineInputBorder(
        borderSide:  const BorderSide(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  const BorderSide(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),

      prefixIcon: icon,
      suffixIcon: suffixIcon,


    ),
    style: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    keyboardType: textInputType,
    obscureText: password,
    controller: controller ,
    validator: (value){
      if(value!.isEmpty){
        return textValidator;
      }
    },

  );


}


Widget dafaultRegisterFormField(
    {
      required  String ?label,
      String ?hint,
      required  Widget ?icon,
      Widget ?suffixIcon,
      bool password = false,
      required  TextEditingController ?controller,
      required  TextInputType ?textInputType,
      required  String ?textValidator,
      context
    }
    ){

  return TextFormField(
    decoration:  InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
          fontSize: 15,
          color: Colors.black
      ),
      hintText: hint,
      helperStyle: const TextStyle(),
      enabledBorder:  OutlineInputBorder(
        borderSide:  const BorderSide(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      border:  OutlineInputBorder(
        borderSide:  const BorderSide(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  const BorderSide(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(5),
      ),

      prefixIcon: icon,
      suffixIcon: suffixIcon,


    ),
    style: const TextStyle(
      fontWeight: FontWeight.bold,
    ),
    keyboardType: textInputType,
    obscureText: password,
    controller: controller ,
    validator: (value){
      if(   value !=RegisterCubit.get(context).passController.text  ){
        return textValidator;
      }
      if( value!.isEmpty ){
        return textValidator;
      }
    },

  );


}

Future navigateTo(context,widget)async{

  Navigator.push(context, MaterialPageRoute(builder: (_){
    return widget;
  }));
}

void navigateAndFinish(context,widget){

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
    return widget;
  }));
}

void customToast(String message,Color color){

  Fluttertoast.showToast(
      msg:message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: color,
      textColor: Colors.white,
      fontSize: 16.0
  );
}