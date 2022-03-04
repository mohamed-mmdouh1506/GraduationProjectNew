import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_auth/email_auth.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/container_screen.dart';
import 'package:final_project/models/registerModel/register_model.dart';
import 'package:final_project/models/userModel/user_model.dart';
import 'package:final_project/modules/login/login_screen.dart';
import 'package:final_project/modules/register/email_verified.dart';
import 'package:final_project/modules/register/registercubit/states.dart';
import 'package:final_project/modules/register/student_register_screen.dart';
import 'package:final_project/shared/local/cash_helper.dart';
import 'package:final_project/shared/local/diohelper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:email_auth/email_auth.dart';
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

  var otpController=TextEditingController();
  var otp1Controller=TextEditingController();
  var otp2Controller=TextEditingController();
  var otp3Controller=TextEditingController();
  var otp4Controller=TextEditingController();
  var otp5Controller=TextEditingController();
  var otp6Controller=TextEditingController();


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
  bool isVerify=false;



  var height=70.0;
  Future formValidate(context,widget)async{
    if(widget is EmailVerified){
      checkDoctor();
    }
    if(widget is LoginScreen){
      countValue=1;
    }
    height=(MediaQuery.of(context).size.height*.115);
    if(registerKey.currentState!.validate()){
      if(countValue==1){
        countValue=0;
        print(profileImage==null);
        if(profileImage!=null){
          uploadUserImage().then((value) {
            navigateTo(context, widget);
          });
        }
        else{
          checkRegister=true;
          userRegister(username: usernameValue!,
              email: emailValue!,
              password: passValue!,
              start_at: startAtValue!,
              grade: gradeValue!,
              depertment: departmentValue!,
              fullname: setNameController.text,
              bio: setBioController.text,
              isDoctor: CashHelper.getData(key: 'isDoctor')
          ).then((value) {
            navigateTo(context, widget);
          });
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


  bool isDoctor=false;
  void checkDoctor(){

    if(emailController.text.contains('${1}')
        || emailController.text.contains('${2}')
        || emailController.text.contains('${3}')
        || emailController.text.contains('${4}')
        || emailController.text.contains('${5}')
        || emailController.text.contains('${6}')
        || emailController.text.contains('${7}')
        || emailController.text.contains('${8}')
        || emailController.text.contains('${9}')
    ){

        isDoctor=false;
        print(isDoctor);
        CashHelper.saveData(key: 'isDoctor',value:isDoctor );
        emit(IsDoctorState());
    }
    else{
      isDoctor=true;
      CashHelper.saveData(key: 'isDoctor',value:isDoctor );
      print(isDoctor);
      emit(IsDoctorState());
    }

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
    print(value);
    emit(ChangeDropDownValeState());
  }

  void changeDropDownValue2 (value)
  {
    dropDownValue2 = value ;
    print(value);
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


  Future userRegister({
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
    required bool isDoctor
  })
  {
     return FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password).
         then((value) {
        createUser(
           username: username,
           email: email,
           start_at: start_at,
           grade: grade,
           depertment: depertment,
           fullname: fullname,
           bio: bio,
            isDoctor: isDoctor,
            image:image,
           uId: value.user!.uid);

          if(depertment=='General'){
            if(grade=='First'){
              createStd1(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
            else if(grade=='Second'){
              createStd2(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
            else if(grade=='Fourth'){
              createStd4(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  isDoctor: isDoctor,
                  image:image,
                  uId: value.user!.uid);
            }
            else{
              createStd3(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  isDoctor: isDoctor,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  uId: value.user!.uid);
            }
          }
          else if(depertment=='Security'){
            if(grade=='First'){
              createStd1(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  isDoctor: isDoctor,
                  image:image,
                  uId: value.user!.uid);
            }
            else if(grade=='Second'){
              createStd2(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  isDoctor: isDoctor,
                  image:image,
                  uId: value.user!.uid);
            }
            else if(grade=='Fourth'){
              createStd4(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
            else{
              createStd3(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
          }
          else if(depertment=='Medical'){
            if(grade=='First'){
              createStd1(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
            else if(grade=='Second'){
              createStd2(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
            else if(grade=='Fourth'){
              createStd4(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
            else{
              createStd3(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
          }
          else{
            if(grade=='First'){
              createStd1(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  uId: value.user!.uid,
                  isDoctor: isDoctor
              );
            }
            else if(grade=='Second'){
              createStd2(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
            else if(grade=='Fourth'){
              createStd4(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
            else{
              createStd3(
                  username: username,
                  email: email,
                  start_at: start_at,
                  grade: grade,
                  depertment: depertment,
                  fullname: fullname,
                  bio: bio,
                  image:image,
                  isDoctor: isDoctor,
                  uId: value.user!.uid);
            }
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
    required bool isDoctor


  })
  {
    
    UserModel model=UserModel(
      username: username,
      email: email,
      startAt: start_at,
      grade: grade,
      bio: bio,
      image: image,
      department: depertment,
      fullName: fullname,
      uId: uId,
      isDoctor: isDoctor
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
    required bool isDoctor

  })
  {

    UserModel model=UserModel(
        username: username,
        email: email,
        startAt: start_at,
        grade: grade,
        bio: bio,
        image: image,
        department: depertment,
        fullName: fullname,
        uId: uId,
        isDoctor: isDoctor
    );

    FirebaseFirestore.instance
        .collection(depertment).doc('grade1').collection('users').doc(uId)
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
    required bool isDoctor

  })
  {

    UserModel model=UserModel(
        username: username,
        email: email,
        startAt: start_at,
        grade: grade,
        bio: bio,
        image: image,
        department: depertment,
        fullName: fullname,
        uId: uId,
        isDoctor: isDoctor
    );

    FirebaseFirestore.instance
        .collection(depertment).doc('grade2').collection('users').doc(uId)
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
    required bool isDoctor

  })
  {

    UserModel model=UserModel(
        username: username,
        email: email,
        startAt: start_at,
        grade: grade,
        bio: bio,
        image: image,
        department: depertment,
        fullName: fullname,
        uId: uId,
        isDoctor: isDoctor
    );

    FirebaseFirestore.instance
        .collection(depertment).doc('grade3').collection('users').doc(uId)
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
    required bool isDoctor

  })
  {

    UserModel model=UserModel(
        username: username,
        email: email,
        startAt: start_at,
        grade: grade,
        bio: bio,
        image: image,
        department: depertment,
        fullName: fullname,
        uId: uId,
        isDoctor: isDoctor
    );

    FirebaseFirestore.instance
        .collection(depertment).doc('grade4').collection('users').doc(uId)
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
                grade: gradeValue!,
                image: imagePath,
                depertment: departmentValue!,
                fullname: setNameController.text,
                bio: setBioController.text,
                isDoctor:CashHelper.getData(key: 'isDoctor')

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

  EmailAuth emailAuth =  EmailAuth(sessionName: "Complete Register");

  void SendOtp() async{
    var res=await emailAuth.sendOtp(
        recipientMail: emailValue!, otpLength: 5
    );
    isVerify=true;
    emit(SendOTPState());
  }

  void VerifyOtp(context){
    var res= emailAuth.validateOtp(recipientMail: otpController.text,
        userOtp:otp1Controller.text+otp2Controller.text+otp3Controller.text+
            otp4Controller.text+otp5Controller.text+otp6Controller.text);

    if(res){
      isVerify=true;
      print('Verify Successfull');
      customToast('Validation successfully', Colors.green);
      navigateTo(context, StudentRegisterScreen());
      emit(VerifyOTPState());
    }
    else{
      print(otp1Controller.text+otp2Controller.text+otp3Controller.text+
          otp4Controller.text+otp5Controller.text+otp6Controller.text);
      print('Verify Faild');
      customToast('OTP isn\'t correct' , Colors.red);

      emit(VerifyOTPState());
    }
  }

}