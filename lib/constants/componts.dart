import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
    }
    ){

  return TextFormField(
    decoration:  InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
          color: Colors.black

      ),
      hintText: hint,
      helperStyle: const TextStyle(),
      enabledBorder:  OutlineInputBorder(
        borderSide:  const BorderSide(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(25),
      ),
      border:  OutlineInputBorder(
        borderSide:  const BorderSide(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(25),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide:  const BorderSide(width: 1,color: Colors.black),
        borderRadius: BorderRadius.circular(25),
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

void navigateTo(context,widget){

  Navigator.push(context, MaterialPageRoute(builder: (_){
    return widget;
  }));
}

void navigateAndFinish(context,widget){

  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_){
    return widget;
  }));
}