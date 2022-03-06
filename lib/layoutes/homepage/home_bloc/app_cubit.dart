import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/layout_screen.dart';
import 'package:final_project/models/groupModel/group_model.dart';
import 'package:final_project/models/homeModel/home_model.dart';
import 'package:final_project/models/materialModel.dart';
import 'package:final_project/modules/addPost/add_post.dart';
import 'package:final_project/modules/groupsScreen/group_screen.dart';
import 'package:final_project/modules/homeScreen/home_screen.dart';
import 'package:final_project/modules/materialsScreen/doctor_material_screen.dart';
import 'package:final_project/modules/materialsScreen/student_material_screen.dart';
import 'package:final_project/modules/settings/setting_screen.dart';
import 'package:final_project/shared/local/cash_helper.dart';
import 'package:final_project/shared/local/diohelper.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

import '../../../models/PostModel.dart';
import '../../../models/userModel/user_model.dart';
import '../../../shared/Componant/Constants.dart';

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

  UserModel? userModel;

   void getUserData() {
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      //print(value.data());
      userModel = UserModel.formJson(value.data()!);
      print('user Data : ${value.data()}');
      emit(GetUserDataSuccessState());
    }).catchError((error) {
      print('error when get userData : ${error.toString()}');
      emit(GetUserDataErrorState());
    });
  }



  File? uploadedPostImage ;
  var picker = ImagePicker();

  Future <void> getPostImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadedPostImage = File(pickedFile.path);
      emit(UploadPostImageSuccessState());
    } else {
      print('No Image selected.');
      emit(UploadPostImageErrorState());
    }
  }

  void removePostImage() {
    uploadedPostImage = null;
    emit(RemovePostImageState());
  }


  void createPostWithImage ({
    required String postDate,
    required String postText,
  })
  {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(uploadedPostImage!.path)
        .pathSegments.last}').putFile(uploadedPostImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        createPost(
          postDate: postDate,
          postText: postText,
          postImage: value,
        );

        print('image url ${value.toString()}');
        emit(CreatePostSuccessState());

      }).catchError((error){
        print('Error When Create post with image : ${error.toString()}');
        emit(CreatePostErrorState());
      });
    }).catchError((error){
      print('Error When Upload image in Firesorage : ${error.toString()}');
      emit(CreatePostErrorState());
    });
  }
  
  void createPost ({
    required String postDate,
    required String postText,
    String? postImage,
  })
  {
    emit(CreatePostLoadingState());
    PostModel model = PostModel(
      username: userModel?.fullName,
      userImage: userModel?.image,
      userId: userModel?.uId,
      postDate: postDate,
      postText: postText,
      postImage: postImage ?? '',
    );

    FirebaseFirestore.instance.collection('homePost')
        .add(model.toMap())
        .then((value) {
      print('Post Uploaded Successful : ${value.toString()}');
      // value.snapshots().listen((event) {
      //
      // });
      emit(CreatePostSuccessState());
    }).catchError((error){
      print('Error When Create New Post : ${error.toString()}');
      emit(CreatePostErrorState());
    });

  }
  

  List <PostModel> homePost = [];
  
  void getHomePost ()
  {
    homePost = [];
    
    FirebaseFirestore.instance
        .collection('homePost')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            homePost.add(PostModel.fromFire(element.data()));
          });
          print(homePost[0].username);
          emit(GetHomePostSuccessState());
    }).catchError((error){
      print('Error when get Home post : ${error.toString()}');
      emit(GetHomePostErrorState());
    });
  }


  List <GroupModel> groupPosts=[];

  String ?gradeGroup= 'Fourth';
  String ?departmentGroup= 'General';

  void getGroupPosts(){
    groupPosts=[];

    emit(GetPostGroupLoadingState());
    if(gradeGroup=='First'){
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade1')
          .collection('posts')
          .get().then((value) {
        value.docs.forEach((element) {
          groupPosts.add(GroupModel.fromFire(element.data()));
        });
        emit(GetPostGroupSuccessState());
      }).catchError((error){

        print('Error in Get GroupPost is ${error.toString()}');
        emit(GetPostGroupErrorState());
      });
    }
    else if(gradeGroup=='Second'){
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade2')
          .collection('posts')
          .get().then((value) {

        value.docs.forEach((element) {
          groupPosts.add(GroupModel.fromFire(element.data()));
        });
        emit(GetPostGroupSuccessState());
      }).catchError((error){

        print('Error in Get GroupPost is ${error.toString()}');
        emit(GetPostGroupErrorState());
      });


    }
    else if(gradeGroup=='Third'){
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade3')
          .collection('posts')
          .get().then((value) {

        value.docs.forEach((element) {
          groupPosts.add(GroupModel.fromFire(element.data()));
        });
        emit(GetPostGroupSuccessState());
      }).catchError((error){

        print('Error in Get GroupPost is ${error.toString()}');
        emit(GetPostGroupErrorState());
      });


    }
    else {
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade4')
          .collection('posts')
          .get().then((value) {

        value.docs.forEach((element) {
          groupPosts.add(GroupModel.fromFire(element.data()));
        });
        emit(GetPostGroupSuccessState());
      }).catchError((error){

        print('Error in Get GroupPost is ${error.toString()}');
        emit(GetPostGroupErrorState());
      });


    }

  }




  File? uploadedPostGroupImage ;

  Future <void> getPostGroupImage() async {
    final pickedFile = await picker.pickImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null) {
      uploadedPostGroupImage = File(pickedFile.path);
      emit(UploadPostGroupImageSuccessState());
    } else {
      print('No Image selected.');
      emit(UploadPostGroupImageErrorState());
    }
  }

  void removePostGroupImage() {
    uploadedPostGroupImage = null;
    emit(RemovePostImageState());
  }


  void createPostGroupWithImage ({
    required String postDate,
    required String postText,
    required BuildContext context ,
  })
  {
    emit(CreatePostLoadingState());
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child('groupposts/${Uri.file(uploadedPostGroupImage!.path)
        .pathSegments.last}').putFile(uploadedPostGroupImage!)
        .then((value){
      value.ref.getDownloadURL().then((value) {
        createGroupPost(
          postDate: postDate,
          postText: postText,
          postImage: value,
          context: context,
        );

        print('image url ${value.toString()}');
        emit(CreatePostGroupSuccessState());

      }).catchError((error){
        print('Error When Create post with image : ${error.toString()}');
        emit(CreatePostGroupErrorState());
      });
    }).catchError((error){
      print('Error When Upload image in Firesorage : ${error.toString()}');
      emit(CreatePostGroupSuccessState());
    });
  }

  void createGroupPost ({
    required String postDate,
    required String postText,
    String? postImage,
    required BuildContext context,
  })
  {
    emit(CreatePostLoadingState());
    GroupModel model = GroupModel(
      username: userModel?.fullName,
      userImage: userModel?.image,
      userId: userModel?.uId,
      postDate: postDate,
      postText: postText,
      postImage: postImage ?? '',
    );

      if(gradeGroup=='First'){
        FirebaseFirestore.instance.collection(departmentGroup!).doc('grade1').
        collection('posts')
            .add(model.toMap())
            .then((value) {
          print('Post Uploaded Successful : ${value.toString()}');
          emit(CreatePostGroupSuccessState());
        }).catchError((error){
          print('Error When Create New Post : ${error.toString()}');
          emit(CreatePostGroupErrorState());
        });
      }
      else if(gradeGroup=='Second'){
        FirebaseFirestore.instance.collection(departmentGroup!).doc('grade2').
        collection('posts')
            .add(model.toMap())
            .then((value) {
          print('Post Uploaded Successful : ${value.toString()}');
          emit(CreatePostGroupSuccessState());
        }).catchError((error){
          print('Error When Create New Post : ${error.toString()}');
          emit(CreatePostGroupErrorState());
        });
      }
      else if(gradeGroup=='Third'){
        FirebaseFirestore.instance.collection(departmentGroup!).doc('grade3').
        collection('posts')
            .add(model.toMap())
            .then((value) {
          print('Post Uploaded Successful : ${value.toString()}');
          emit(CreatePostGroupSuccessState());
        }).catchError((error){
          print('Error When Create New Post : ${error.toString()}');
          emit(CreatePostGroupErrorState());
        });
      }
      else{
        FirebaseFirestore.instance.collection(departmentGroup!).doc('grade4').
        collection('posts')
            .add(model.toMap())
            .then((value) {
          print('Post Uploaded Successful : ${value.toString()}');
          navigateAndFinish(context, const LayoutScreen());
          emit(CreatePostGroupSuccessState());
        }).catchError((error){
          print('Error When Create New Post : ${error.toString()}');
          emit(CreatePostGroupErrorState());
        });
      }

  }



  Future refreshData() async {
    await Future.delayed(Duration(seconds: 3));
    getGroupPosts();
    getHomePost();
    emit(GetPostGroupSuccessState());
  }

  List <UserModel> userFriends = [] ;
  void getUserFriends() {
    userFriends = [];
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').get().then((value){
      value.docs.forEach((element) {
        if(element.data()['grade'] == userModel!.grade.toString() && element.data()['uId'] != userModel!.uId){
          userFriends.add(UserModel.formJson(element.data()));
        }
      });
      print(userFriends.length);
      emit(GetUserFriendsSuccessState());
    }).catchError((error) {
      print('error when get user Friends : ${error.toString()}');
      emit(GetUserFriendsErrorState());
    });
  }

  List <PostModel> userPosts = [];
  List <String> coursesTitle = [];

  void getUserPosts ()
  {
    emit(GetUserPostLoadingState());
    switch (userModel!.grade)
    {
       case 'First' : {
         FirebaseFirestore.instance.collection('General')
             .doc('grade1')
             .collection('posts')
             .get().then((value) {
               value.docs.forEach((element) {
                 if(element.data()['userId'] == userModel!.uId){
                   userPosts.add(PostModel.fromFire(element.data()));
                 }
               });
               emit(GetUserPostSuccessState());
         }).catchError((error){
           print('Error When get user Posts : ${error.toString()}');
           emit(GetUserPostErrorState());
         });
         break;
       }

      case 'Second' : {
        FirebaseFirestore.instance.collection('General')
            .doc('grade2')
            .collection('posts')
            .get().then((value) {
          value.docs.forEach((element) {
            if(element.data()['userId'] == userModel!.uId){
              userPosts.add(PostModel.fromFire(element.data()));
            }
          });
          print(userPosts.length);
          emit(GetUserPostSuccessState());
        }).catchError((error){
          print('Error When get user Posts : ${error.toString()}');
          emit(GetUserPostErrorState());
        });
        break;
      }
      case 'Third' : {
        FirebaseFirestore.instance.collection('General')
            .doc('grade3')
            .collection('posts')
            .get().then((value) {
          value.docs.forEach((element) {
            if(element.data()['userId'] == userModel!.uId){
              userPosts.add(PostModel.fromFire(element.data()));
            }
          });
          emit(GetUserPostSuccessState());
        }).catchError((error){
          print('Error When get user Posts : ${error.toString()}');
          emit(GetUserPostErrorState());
        });
        break;
      }

      case 'Fourth' : {
        FirebaseFirestore.instance.collection('General')
            .doc('grade4')
            .collection('posts')
            .get().then((value) {
          value.docs.forEach((element) {
            if(element.data()['userId'] == userModel!.uId){
              userPosts.add(PostModel.fromFire(element.data()));
            }
          });
          emit(GetUserPostSuccessState());
        }).catchError((error){
          print('Error When get user Posts : ${error.toString()}');
          emit(GetUserPostErrorState());
        });
        break;
      }
    }
  }


  void getMaterialTitles ()
  {
    switch (userModel!.grade)
    {
      case 'First' : {
        FirebaseFirestore.instance.collection('General')
            .doc('grade1')
            .collection('Material')
            .get().then((value) {
          value.docs.forEach((element) {
            coursesTitle.add(element.id.toString());
          });
          emit(GetUserPostSuccessState());
        }).catchError((error){
          print('Error When get user Posts : ${error.toString()}');
          emit(GetUserPostErrorState());
        });
        break;
      }
      case 'Second' : {
        FirebaseFirestore.instance.collection('General')
            .doc('grade2')
            .collection('Material')
            .get().then((value) {
          value.docs.forEach((element) {
            coursesTitle.add(element.id.toString());
          });
          print(coursesTitle.length);
          emit(GetUserPostSuccessState());
        }).catchError((error){
          print('Error When get user Posts : ${error.toString()}');
          emit(GetUserPostErrorState());
        });
        break;
      }
      case 'Third' : {
        FirebaseFirestore.instance.collection('General')
            .doc('grade3')
            .collection('Material')
            .get().then((value) {
          value.docs.forEach((element) {
            coursesTitle.add(element.id.toString());
          });
          print(coursesTitle.length);
          emit(GetUserPostSuccessState());
        }).catchError((error){
          print('Error When get user Posts : ${error.toString()}');
          emit(GetUserPostErrorState());
        });
        break;
      }

      case 'Fourth' : {
        FirebaseFirestore.instance.collection('General')
            .doc('grade4')
            .collection('Material')
            .get().then((value) {
          value.docs.forEach((element) {
            coursesTitle.add(element.id.toString());
          });
          print(coursesTitle.length);
          emit(GetUserPostSuccessState());
        }).catchError((error){
          print('Error When get user Posts : ${error.toString()}');
          emit(GetUserPostErrorState());
        });
        break;
      }
    }
  }


  List <MaterialModel> lecture = [];
  List <MaterialModel> section = [];

  void getMaterial ()
  {
    FirebaseFirestore.instance.collection('General')
        .doc('grade4')
        .collection('Material')
        .doc('imageProcessing')
        .collection('lecture')
        .get().then((value) {
          value.docs.forEach((element) {
            lecture.add(MaterialModel.fromFire(element.data()));
          });
          print('lecture size : ${lecture.length}');
          emit(GetMaterialSuccessState());
    }).catchError((error){
      print('Error when get Material : ${error.toString()}');
      emit(GetMaterialErrorState());
    });

    FirebaseFirestore.instance.collection('General')
        .doc('grade4')
        .collection('Material')
        .doc('imageProcessing')
        .collection('section')
        .get().then((value) {
      value.docs.forEach((element) {
        section.add(MaterialModel.fromFire(element.data()));
      });
      emit(GetMaterialSuccessState());
    }).catchError((error){
      print('Error when get Material : ${error.toString()}');
      emit(GetMaterialErrorState());
    });

  }


}