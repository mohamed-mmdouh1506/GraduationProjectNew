import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/container_screen.dart';
import 'package:final_project/models/registerModel/register_model.dart';
import 'package:final_project/models/userModel/user_model.dart';
import 'package:final_project/modules/login/login_screen.dart';
import 'package:final_project/modules/register/registercubit/states.dart';
import 'package:final_project/modules/register/student_register_screen.dart';
import 'package:final_project/shared/local/cash_helper.dart';
import 'package:final_project/shared/local/diohelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;


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
  String ?gradeValue=CashHelper.getUserName(key: 'grade');
  String ?departmentValue=CashHelper.getUserName(key: 'department');
  String? imagePath;
  var registerKey = GlobalKey<FormState>();
  int ?count=0;
  int ?countValue=0;

  var height=70.0;
  Future formValidate(context,widget)async{
    if(widget is LoginScreen){
      countValue=1;
    }
    height=(MediaQuery.of(context).size.height*.115);
    if(registerKey.currentState!.validate()){
      count=count!+1;
      if(countValue==1){
        countValue=0;
        print(profileImage==null);
        if(profileImage!=null){
          uploadUserImage().then((value) {
            navigateTo(context, widget);
          });
        }
        else{
          userRegister(username: usernameValue!,
              email: emailValue!,
              password: passValue!,
              start_at: startAtValue!,
              grade: gradeValue!,
              depertment: departmentValue!,
              fullname: setNameController.text,
              bio: setBioController.text
          );
          checkRegister=true;
        }
    }
      else{
        navigateTo(context, widget);
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

  String dropDownValue1 = '';
  String dropDownValue2 = '';

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
      print('Path is ${pickedFile.path}');
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


  // RegisterModel ?Model;
  //
  // void userRegister({
  //   required String username,
  //   required String email,
  //   required String password,
  //   required String start_at,
  //   required String grade,
  //   required String depertment,
  //
  //   String ?image,
  //   required String fullname,
  //   required String bio,
  //   context,
  // })
  // {
  //   DioHelper.postDate(url:'auth/local/register', data: {
  //
  //     "username": username,
  //     "email": email,
  //     "password": password,
  //     "start_at": start_at,
  //     "grade": grade,
  //     "depertment": depertment,
  //     "image":image,
  //     "bio": bio,
  //     "fullname": fullname
  //
  //   }).then((value) {
  //     Model=RegisterModel.fromJson(value.data);
  //     print(value.data);
  //     emit(UserRegisterSuccessState());
  //   }).catchError((error){
  //
  //     print('Error in Register is ${error.toString()}');
  //     emit(UserRegisterErrorState());
  //   });
  // }
  //


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
     FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).
     then((value) {
       createUser(
           username: username,
           email: email,
           start_at: start_at,
           grade: grade,
           depertment: depertment,
           fullname: fullname,
           bio: bio,
           image:image,
           uId: value.user!.uid);
       if(gradeValue=='First'){
         createStd1(
             username: username,
             email: email,
             start_at: start_at,
             grade: grade,
             depertment: depertment,
             fullname: fullname,
             bio: bio,
             image:image,
             uId: value.user!.uid);
       }
       else if(gradeValue=='Second'){
         createStd2(
             username: username,
             email: email,
             start_at: start_at,
             grade: grade,
             depertment: depertment,
             fullname: fullname,
             bio: bio,
             image:image,
             uId: value.user!.uid);
       }
       else if(gradeValue=='Third'){
         createStd3(
             username: username,
             email: email,
             start_at: start_at,
             grade: grade,
             depertment: depertment,
             fullname: fullname,
             bio: bio,
             image:image,
             uId: value.user!.uid);
       }
       else{
         createStd4(
             username: username,
             email: email,
             start_at: start_at,
             grade: grade,
             depertment: depertment,
             fullname: fullname,
             bio: bio,
             image:image,
             uId: value.user!.uid);
       }
       print('Register Success');
       print(value.user!.email);
       emit(UserRegisterSuccessState());
     }).catchError((error){
       print(error.toString());
       emit(UserRegisterErrorState());
     });
  }


  void createUser({
    required String username,
    required String email,
    required String start_at,
    required String grade,
    required String depertment,
    String ?image,
    required String fullname,
    required String bio,
    required String uId,

  })
  {
    
    UserModel model=UserModel(
      username: username,
      email: email,
      start_at: start_at,
      grade: grade,
      bio: bio,
      image: image,
      depertment: depertment,
      fullname: fullname,
      uId: uId
    );
    
     FirebaseFirestore.instance
     .collection('users').doc(uId)
     .set(model.toMap()).then((value) {

       print('Create User Success');
       emit(PostUserSuccessState());

     }).catchError((error){

       print('Error in Create User is ${error.toString()}');
       emit(PostUserErrorState());

     });
    
  }

  void createStd1({
    required String username,
    required String email,
    required String start_at,
    required String grade,
    required String depertment,
    String ?image,
    required String fullname,
    required String bio,
    required String uId,

  })
  {

    UserModel model=UserModel(
        username: username,
        email: email,
        start_at: start_at,
        grade: grade,
        bio: bio,
        image: image,
        depertment: depertment,
        fullname: fullname,
        uId: uId
    );

    FirebaseFirestore.instance
        .collection('std1').doc(uId)
        .set(model.toMap()).then((value) {

      print('Create Std1 Success');
      emit(PostStd1SuccessState());

    }).catchError((error){

      print('Error in Create Std1 is ${error.toString()}');
      emit(PostStd1ErrorState());

    });

  }


  void createStd2({
    required String username,
    required String email,
    required String start_at,
    required String grade,
    required String depertment,
    String ?image,
    required String fullname,
    required String bio,
    required String uId,

  })
  {

    UserModel model=UserModel(
        username: username,
        email: email,
        start_at: start_at,
        grade: grade,
        bio: bio,
        image: image,
        depertment: depertment,
        fullname: fullname,
        uId: uId
    );

    FirebaseFirestore.instance
        .collection('std2').doc(uId)
        .set(model.toMap()).then((value) {

      print('Create Std2 Success');
      emit(PostStd2SuccessState());

    }).catchError((error){

      print('Error in Create Std2 is ${error.toString()}');
      emit(PostStd2ErrorState());

    });

  }


  void createStd3({
    required String username,
    required String email,
    required String start_at,
    required String grade,
    required String depertment,
    String ?image,
    required String fullname,
    required String bio,
    required String uId,

  })
  {

    UserModel model=UserModel(
        username: username,
        email: email,
        start_at: start_at,
        grade: grade,
        bio: bio,
        image: image,
        depertment: depertment,
        fullname: fullname,
        uId: uId
    );

    FirebaseFirestore.instance
        .collection('Std3').doc(uId)
        .set(model.toMap()).then((value) {

      print('Create Std3 Success');
      emit(PostStd3SuccessState());

    }).catchError((error){

      print('Error in Create Std3 is ${error.toString()}');
      emit(PostStd3ErrorState());

    });

  }


  void createStd4({
    required String username,
    required String email,
    required String start_at,
    required String grade,
    required String depertment,
    String ?image,
    required String fullname,
    required String bio,
    required String uId,

  })
  {

    UserModel model=UserModel(
        username: username,
        email: email,
        start_at: start_at,
        grade: grade,
        bio: bio,
        image: image,
        depertment: depertment,
        fullname: fullname,
        uId: uId
    );

    FirebaseFirestore.instance
        .collection('Std4').doc(uId)
        .set(model.toMap()).then((value) {

      print('Create Std4 Success');
      emit(PostStd4SuccessState());

    }).catchError((error){

      print('Error in Create Std4 is ${error.toString()}');
      emit(PostStd4ErrorState());

    });

  }


  bool ?checkRegister=true;

  Future uploadUserImage(){

    emit(UploadUserProfileImageLoadingState());
    return firebase_storage.FirebaseStorage.instance.ref()
    .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!).then((value) {

          value.ref.getDownloadURL().then((value) {

            print('Upload Success');
            print(value);
            imagePath=value;
            userRegister(username: usernameValue!,
                email: emailValue!,
                password: passValue!,
                start_at: startAtValue!,
                grade: 'Fourth',
                image: imagePath,
                depertment: 'Computer Science',
                fullname: setNameController.text,
                bio: setBioController.text
            );
            checkRegister=true;
            emit(UploadProfileImageSuccessState());

          }).catchError((error){

            print('Error in Upload profileImage ${error.toString()}');
            emit(UploadUserProfileImageErrorState());

          });

    }).catchError((error){

      print('Error in Upload profileImage ${error.toString()}');
      emit(UploadUserProfileImageErrorState());
    });


  }

}