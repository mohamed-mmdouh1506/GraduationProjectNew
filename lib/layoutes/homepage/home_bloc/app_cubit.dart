import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/layout_screen.dart';
import 'package:final_project/models/groupModel/group_model.dart';
import 'package:final_project/models/homeModel/home_model.dart';
import 'package:final_project/models/materialModel.dart';
import 'package:final_project/modules/BotScreen/BotScreen.dart';
import 'package:final_project/modules/addPost/add_post.dart';
import 'package:final_project/modules/groupsScreen/group_screen.dart';
import 'package:final_project/modules/homeScreen/home_screen.dart';
import 'package:final_project/modules/materialsScreen/doctor_material_screen.dart';
import 'package:final_project/modules/materialsScreen/student_material_screen.dart';
import 'package:final_project/modules/settings/setting_screen.dart';
import 'package:final_project/shared/local/cash_helper.dart';
import 'package:final_project/shared/local/diohelper.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:bloc/bloc.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../models/CommentModel.dart';
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

  List <Widget> studentScreens =[
    const HomeScreen(),
    const GroupScreen(),
    StudentMaterialScreen(),
    const SettingScreen(),
  ];

  List <Widget> doctorScreens =[
    const HomeScreen(),
    const GroupScreen(),
    DoctorMaterialScreen(),
    const SettingScreen(),
  ];



  List <String> Titles =[
    'HomeScreen',
    'GroupScreen',
    'MaterialScreen',
    'SettingScreen',
  ];


  bool ?doctorCheck;

  UserModel? userModel;

   Future<void> getUserData() async{
    emit(GetUserDataLoadingState());
    FirebaseFirestore.instance.collection('users').doc(uId).get().then((value) {
      userModel = UserModel.formJson(value.data()!);
      doctorCheck=userModel!.isDoctor;
      print('user Data : ${value.data()}');;
      getUserFriends();
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
  List<String> homePostsId = [];
  List<String> groupPostsId = [];
  List<int> homeLikes = [];
  List<int> groupLikes = [];
  List<int> homeCommentsNumber = [];
  List<int> groupCommentsNumber = [];
  List<CommentModel> homeComments = [];
  List<CommentModel> groupComments = [];

  void getHomePost ()
  {
    homePost = [];
    FirebaseFirestore.instance
        .collection('homePost')
        .orderBy('postDate')
        .get()
        .then((value) {
          value.docs.forEach((element) {
            element.reference.collection('comments').get().then((value) {
              homeCommentsNumber.add(value.docs.length);
              homePostsId.add(element.id);
              homePost.add(PostModel.fromFire(element.data()));
            });
            element.reference.collection('likes').get().then((value) {
              homeLikes.add(value.docs.length);
            }).catchError((error){});
          });
          print(homePost[0].username);
          emit(GetHomePostSuccessState());
    }).catchError((error){
      print('Error when get Home post : ${error.toString()}');
      emit(GetHomePostErrorState());
    });
  }


  List <GroupModel> groupPosts=[];

  String ?gradeGroup=CashHelper.getUserName(key: 'grade');
  String ?departmentGroup=CashHelper.getUserName(key: 'department');

  void prin(){
    print(gradeGroup);
    print(departmentGroup);
  }


  void getGroupPosts(){
    groupPosts=[];

    emit(GetPostGroupLoadingState());
    if(userModel?.grade == 'First'){
      FirebaseFirestore.instance.collection((userModel!.department)!)
          .doc('grade1')
          .collection('posts').orderBy('postDate')
          .get()
          .then((value) {
        value.docs.forEach((element) {
          element.reference.collection('comments').get().then((value) {
            groupCommentsNumber.add(value.docs.length);
            groupPostsId.add(element.id);
            groupPosts.add(GroupModel.fromFire(element.data()));
          });
          element.reference.collection('likes').get().then((value) {
            groupLikes.add(value.docs.length);
          });
        });
        emit(GetPostGroupSuccessState());
      }).catchError((error){

        print('Error in Get GroupPost is ${error.toString()}');
        emit(GetPostGroupErrorState());
      });
    }
    else if(userModel?.grade =='Second'){
      FirebaseFirestore.instance.collection((userModel!.department)!)
          .doc('grade2')
          .collection('posts')
          .get().then((value) {
        value.docs.forEach((element) {
          element.reference.collection('comments').get().then((value) {
            groupCommentsNumber.add(value.docs.length);
            groupPostsId.add(element.id);
            groupPosts.add(GroupModel.fromFire(element.data()));
          });
          element.reference.collection('likes').get().then((value) {
            groupLikes.add(value.docs.length);
          });
        });
        emit(GetPostGroupSuccessState());
      }).catchError((error){

        print('Error in Get GroupPost is ${error.toString()}');
        emit(GetPostGroupErrorState());
      });


    }
    else if(userModel?.grade =='Third'){
      FirebaseFirestore.instance.collection((userModel!.department)!)
          .doc('grade3')
          .collection('posts')
          .get().then((value) {
        value.docs.forEach((element) {
          element.reference.collection('comments').get().then((value) {
            groupCommentsNumber.add(value.docs.length);
            groupPostsId.add(element.id);
            groupPosts.add(GroupModel.fromFire(element.data()));
          });
          element.reference.collection('likes').get().then((value) {
            groupLikes.add(value.docs.length);
          });
        });
        emit(GetPostGroupSuccessState());
      }).catchError((error){

        print('Error in Get GroupPost is ${error.toString()}');
        emit(GetPostGroupErrorState());
      });


    }
    else if(userModel?.grade =='Fourth'){
      FirebaseFirestore.instance.collection((userModel!.department)!)
          .doc('grade4')
          .collection('posts')
          .get().then((value) {
        value.docs.forEach((element) {
          element.reference.collection('comments').get().then((value) {
            groupCommentsNumber.add(value.docs.length);
            groupPostsId.add(element.id);
            groupPosts.add(GroupModel.fromFire(element.data()));
          });
          element.reference.collection('likes').get().then((value) {
            groupLikes.add(value.docs.length);
          });
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
  List <String> coursesDoctorTitle = [];


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
    coursesTitle = [];
    switch (userModel?.grade)
    {
      case 'First' : {
        FirebaseFirestore.instance.collection((userModel!.department)!)
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
        FirebaseFirestore.instance.collection((userModel!.department)!)
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
        FirebaseFirestore.instance.collection((userModel!.department)!)
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
        FirebaseFirestore.instance.collection((userModel!.department)!)
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

  Future getDoctorMaterialTitles ()async
  {
    coursesDoctorTitle=[];
    if(CashHelper.getData(key: 'gradeDrop')=='First'){
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade1')
          .collection('Material')
          .get().then((value) {
        value.docs.forEach((element) {
          coursesDoctorTitle.add(element.id.toString());
        });
        print('lecture size : ${lecture.length}');
        emit(GetMaterialSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetMaterialErrorState());
      });

    }
    else if(CashHelper.getData(key: 'gradeDrop')=='Second'){
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade2')
          .collection('Material')
          .get().then((value) {
        value.docs.forEach((element) {
          coursesDoctorTitle.add(element.id.toString());
        });
        print('lecture size : ${lecture.length}');
        emit(GetMaterialSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetMaterialErrorState());
      });
    }
    else if(CashHelper.getData(key: 'gradeDrop')=='Third'){
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade3')
          .collection('Material')
          .get().then((value) {
        value.docs.forEach((element) {
          coursesDoctorTitle.add(element.id.toString());
        });
        print('lecture size : ${lecture.length}');
        emit(GetMaterialSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetMaterialErrorState());
      });
    }
    else {
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade4')
          .collection('Material')
          .get().then((value) {
        value.docs.forEach((element) {
          coursesDoctorTitle.add(element.id.toString());
        });
        print('lecture size : ${lecture.length}');
        emit(GetMaterialSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetMaterialErrorState());
      });
    }

  }

  List <MaterialModel> lecture = [];
  List <MaterialModel> section = [];


  UserModel? selectedUserModel;

  void getSelectedUserData({
    required String selectedUserId,
  })
  {
    emit(GetSelectedUserLoadingState());
    FirebaseFirestore.instance.collection('users').doc(selectedUserId).get().then((value) {
      selectedUserModel = UserModel.formJson(value.data()!);
      emit(GetSelectedUserSuccessState());
    }).catchError((error) {
      print('error when get selected User Model : ${error.toString()}');
      emit(GetSelectedUserErrorState());
    });
  }


  List <PostModel> selectedUserPosts = [];
  void getSelectedUserPosts()
  {
    FirebaseFirestore.instance
        .collection('posts')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        element.reference.collection('comments').get().then((value) {
          homeCommentsNumber.add(value.docs.length);
          homePostsId.add(element.id);
          if(PostModel.fromFire(element.data()).userId == selectedUserModel!.uId) {
            selectedUserPosts.add(PostModel.fromFire(element.data()));
          }
        }).catchError((error){});
        element.reference.collection('likes').get().then((value) {
          homeLikes.add(value.docs.length);
        }).catchError((error){});
      });

      emit(GetSelectedUserPostSuccessState());
    }).catchError((error){
      print('error when get posts ${error.toString()}');
      emit(GetSelectedUserPostErrorState());
    });

  }


  void likeHomePost(String postId) {
    FirebaseFirestore.instance
        .collection('homePost')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .set({
      'like': true,
      'userName' : userModel!.fullName,
    }).then((value) {
      emit(LikePostsSuccessState());
    }).catchError((error) {
      print('Error When set likes : ${error.toString()}');
      emit(LikePostsErrorState());
    });
  }
  void dislikeHomePost (String postId) {
    FirebaseFirestore.instance
        .collection('homePost')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .delete().then((value) {
      emit(DisLikePostsSuccessState());
    }).catchError((error) {
      print('Error When set likes : ${error.toString()}');
      emit(DisLikePostsErrorState());
    });
  }

  bool isLike = false;
  void likeClick (String postId){
    FirebaseFirestore.instance
        .collection('homePost')
        .doc(postId)
        .collection('likes')
        .doc(userModel!.uId)
        .get().then((value) {
          if (value.get('like') == true)
            {
              dislikeHomePost(postId);
              print('disliked post');
            }
      emit(LikePostsSuccessState());
    }).catchError((error) {
      print('Error When set likes : ${error.toString()}');
      if (error.toString() == 'Bad state: cannot get a field on a DocumentSnapshotPlatform which does not exist')
        {
          likeHomePost(postId);
          print('liked post');
        }
      emit(LikePostsErrorState());
    });
  }

  void likeGroupPost(String postId) {
    switch(userModel!.department)
    {
      case 'General' : {
        switch (userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Second' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Third' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Fourth' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }

        }
        break;
      }

      case 'Medical' : {
        switch (userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('Medical')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Second' : {
            FirebaseFirestore.instance.collection('Medical')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Third' : {
            FirebaseFirestore.instance.collection('Medical')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Fourth' : {
            FirebaseFirestore.instance.collection('Medical')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
        }
        break;
      }

      case 'Security' : {
        switch (userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('Security')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Second' : {
            FirebaseFirestore.instance.collection('Security')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Third' : {
            FirebaseFirestore.instance.collection('Security')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Fourth' : {
            FirebaseFirestore.instance.collection('Security')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
        }
        break;
      }

      case 'Network' : {
        switch (userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('Network')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Second' : {
            FirebaseFirestore.instance.collection('Network')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Third' : {
            FirebaseFirestore.instance.collection('Network')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
          case 'Fourth' : {
            FirebaseFirestore.instance.collection('Network')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .collection('likes')
                .doc(userModel!.uId)
                .set({
              'like': true,
              'userName' : userModel!.fullName,
            }).then((value) {
              emit(LikePostsSuccessState());
            }).catchError((error) {
              print('Error When set likes : ${error.toString()}');
              emit(LikePostsErrorState());
            });
            break;
          }
        }
        break;
      }
    }
  }

  void commentHomePost(String postId, String comment) {
    CommentModel model = CommentModel(
      username: userModel!.fullName!,
      userImage: userModel!.image!,
      userId: userModel!.uId,
      comment: comment,
    );
    FirebaseFirestore.instance
        .collection('homePost')
        .doc(postId)
        .collection('comments')
        .add(model.toMap())
        .then((value) {
      value.snapshots().listen((event) {
        homeComments = [] ;
        getHomeComments(postId);
      });
      emit(CommentPostsSuccessState());
    }).catchError((error) {
      print('Error When set comment in home : ${error.toString()}');
      emit(CommentPostsErrorState());
    });
  }

  void commentGroupPost(String postId, String comment) {
    CommentModel model = CommentModel(
      username: userModel!.fullName!,
      userImage: userModel!.image!,
      userId: userModel!.uId,
      comment: comment,
    );

    switch (userModel!.department)
    {
      case 'General' : {
        switch (userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Second' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Third' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Fourth' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }
        }
        break;
      }

      case 'Medical' : {
        switch (userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('Medical')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Second' : {
            FirebaseFirestore.instance.collection('Medical')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Third' : {
            FirebaseFirestore.instance.collection('Medical')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Fourth' : {
            FirebaseFirestore.instance.collection('Medical')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }
        }
        break;
      }

      case 'Security' : {
        switch (userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('Security')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Second' : {
            FirebaseFirestore.instance.collection('Security')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Third' : {
            FirebaseFirestore.instance.collection('Security')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Fourth' : {
            FirebaseFirestore.instance.collection('Security')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }
        }
        break;
      }

      case 'Network' : {
        switch (userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('Network')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Second' : {
            FirebaseFirestore.instance.collection('Network')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Third' : {
            FirebaseFirestore.instance.collection('Network')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }

          case 'Fourth' : {
            FirebaseFirestore.instance.collection('Network')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .collection('comments')
                .add(model.toMap())
                .then((value) {
              value.snapshots().listen((event) {
                groupComments = [];
                getGroupComments(postId: postId);
              });
              emit(CommentPostsSuccessState());
            }).catchError((error) {
              print('Error When set comment in home : ${error.toString()}');
              emit(CommentPostsErrorState());
            });
            break;
          }
        }
        break;
      }

    }

  }

  void getHomeComments(String postId) {
    homeComments = [];
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .get()
        .then((value) {
      value.reference.collection('comments').get().then((value) {
        value.docs.forEach((element) {
          homeComments.add(CommentModel.fromFire(element.data()));
        });
        emit(GetCommentsSuccessState());
      }).catchError((error) {
        print('Error When get Comments : ${error.toString()}');
      });
    }).catchError((error) {
      emit(GetCommentsErrorState());
    });
  }


  void getGroupComments ({required String postId})
  {
    groupComments = [];

    switch (userModel!.department)
    {

      case 'General' : {

        switch(userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

          case 'Second' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

          case 'Third' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

          case 'Fourth' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                  print('post Comments : ${element.data()['comment']}');
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

        }
        break;
      }

      case 'Medical' : {

        switch(userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

          case 'Second' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

          case 'Third' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

          case 'Fourth' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

        }
        break;
      }


      case 'Security' : {

        switch(userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

          case 'Second' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }
          case 'Third' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

          case 'Fourth' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }

        }
        break;
      }

      case 'Network' : {

        switch(userModel!.grade)
        {
          case 'First' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade1')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }
          case 'Second' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade2')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }
          case 'Third' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade3')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }
          case 'Fourth' : {
            FirebaseFirestore.instance.collection('General')
                .doc('grade4')
                .collection('posts')
                .doc(postId)
                .get()
                .then((value) {
              value.reference.collection('comments').get().then((value) {
                value.docs.forEach((element) {
                  groupComments.add(CommentModel.fromFire(element.data()));
                });
                emit(GetCommentsSuccessState());
              }).catchError((error) {
                print('Error When get Comments : ${error.toString()}');
              });
            }).catchError((error) {
              emit(GetCommentsErrorState());
            });
            break;
          }
        }
        break;
      }
    }
  }

  String ?courseName;

  void getSection ()
  {
      section=[];
    if(gradeGroup=='First'){
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade1')
          .collection('Material')
          .doc(courseName)
          .collection('section')
          .get().then((value) {
        value.docs.forEach((element) {
          section.add(MaterialModel.fromFire(element.data()));
        });
        emit(GetSectionsSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetSectionsErrorState());
      });

    }
    else if(gradeGroup=='Second'){
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade2')
          .collection('Material')
          .doc(courseName)
          .collection('section')
          .get().then((value) {
        value.docs.forEach((element) {
          section.add(MaterialModel.fromFire(element.data()));
        });
        emit(GetSectionsSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetSectionsErrorState());
      });
    }
    else if(gradeGroup=='Third'){
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade3')
          .collection('Material')
          .doc(courseName)
          .collection('section')
          .get().then((value) {
        value.docs.forEach((element) {
          section.add(MaterialModel.fromFire(element.data()));
        });
        emit(GetSectionsSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetSectionsErrorState());
      });
    }
    else {
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade4')
          .collection('Material')
          .doc(courseName)
          .collection('section')
          .get().then((value) {
        value.docs.forEach((element) {
          section.add(MaterialModel.fromFire(element.data()));
        });
        emit(GetSectionsSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetSectionsErrorState());
      });
    }

  }

  void getMaterial ()
  {
    lecture=[];
    print(courseName);
    if(gradeGroup=='First'){
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade1')
          .collection('Material')
          .doc(courseName)
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

    }
    else if(gradeGroup=='Second'){
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade2')
          .collection('Material')
          .doc(courseName)
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
    }
    else if(gradeGroup=='Third'){
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade3')
          .collection('Material')
          .doc(courseName)
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
    }
    else {
      FirebaseFirestore.instance.collection(departmentGroup!)
          .doc('grade4')
          .collection('Material')
          .doc(courseName)
          .collection('lecture')
          .get().then((value) {
        for (var element in value.docs) {
          lecture.add(MaterialModel.fromFire(element.data()));
        }
        print('lecture size : ${lecture.length}');
        emit(GetMaterialSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetMaterialErrorState());
      });
    }

  }

  void getDoctorSection ()
  {
   section=[];
    if(CashHelper.getData(key: 'gradeDrop')=='First'){
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade1')
          .collection('Material')
          .doc(courseName)
          .collection('section')
          .get().then((value) {
        value.docs.forEach((element) {
          section.add(MaterialModel.fromFire(element.data()));
        });
        emit(GetSectionsSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetSectionsErrorState());
      });

    }
    else if(CashHelper.getData(key: 'gradeDrop')=='Second'){
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade2')
          .collection('Material')
          .doc(courseName)
          .collection('section')
          .get().then((value) {
        value.docs.forEach((element) {
          section.add(MaterialModel.fromFire(element.data()));
        });
        emit(GetSectionsSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetSectionsErrorState());
      });
    }
    else if(CashHelper.getData(key: 'gradeDrop')=='Third'){
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade3')
          .collection('Material')
          .doc(courseName)
          .collection('section')
          .get().then((value) {
        value.docs.forEach((element) {
          section.add(MaterialModel.fromFire(element.data()));
        });
        emit(GetSectionsSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetSectionsErrorState());
      });
    }
    else {
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade4')
          .collection('Material')
          .doc(courseName)
          .collection('section')
          .get().then((value) {
        value.docs.forEach((element) {
          section.add(MaterialModel.fromFire(element.data()));
        });
        emit(GetSectionsSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetSectionsErrorState());
      });
    }

  }

  void getDoctorMaterial ()
  {
     lecture=[];
    print(courseName);
    if(CashHelper.getData(key: 'gradeDrop')=='First'){
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade1')
          .collection('Material')
          .doc(courseName)
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

    }
    else if(CashHelper.getData(key: 'gradeDrop')=='Second'){
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade2')
          .collection('Material')
          .doc(courseName)
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
    }
    else if(CashHelper.getData(key: 'gradeDrop')=='Third'){
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade3')
          .collection('Material')
          .doc(courseName)
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
    }
    else {
      FirebaseFirestore.instance.collection('${CashHelper.getData(key: 'departmentDrop')}')
          .doc('grade4')
          .collection('Material')
          .doc(courseName)
          .collection('lecture')
          .get().then((value) {
        for (var element in value.docs) {
          lecture.add(MaterialModel.fromFire(element.data()));
        }
        print('lecture size : ${lecture.length}');
        emit(GetMaterialSuccessState());
      }).catchError((error){
        print('Error when get Material : ${error.toString()}');
        emit(GetMaterialErrorState());
      });
    }

  }


  List <Color> colorsContainer =[
    const Color(0xffF27069),
    const Color(0xffF6B68D),
    const Color(0xffD6D6D7),
    const Color(0xffFFADFE),
    const Color(0xffBEEECA),
    const Color(0xff9DB9D2),
    const Color(0xffFBA09D),
    const Color(0xffFBDA9D),
    const Color(0xffECD4DC),
    const Color(0xffE9D3C3),
    const Color(0xffA8E9F0),
    const Color(0xffDABECB),

  ];

  List <Color> colorsItem =[
    const Color(0xff5E0C08),
    const Color(0xff97410C),
    const Color(0xff3D3D3E),
    const Color(0xff7A0078),
    const Color(0xff19612B),
    const Color(0xff1A2A38),
    const Color(0xff760905),
    const Color(0xff764E05),
    const Color(0xff552534),
    const Color(0xff593921),
    const Color(0xff126069),
    const Color(0xff412532),

  ];

  // Future showMaterials() async{
  //
  //   if(departmentDropMenu=='General'){
  //
  //     if(gradeDropMenu=='First'){
  //       texts =[
  //         'Introduction',
  //         'Language 1',
  //         'Math 1',
  //         'Physics 1',
  //         'Language of Computer',
  //         'Human Behavior',
  //         'Operating System',
  //         'Language 2',
  //         'Physics 2',
  //         'Language 2',
  //         'C++',
  //         'Electronics',
  //       ];
  //
  //     }
  //     else if(gradeDropMenu=='Second'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else if(gradeDropMenu=='Third'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else {
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //
  //   }
  //
  //   else if(departmentDropMenu=='Security'){
  //
  //     if(gradeDropMenu=='First'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else if(gradeDropMenu=='Second'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else if(gradeDropMenu=='Third'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else {
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //
  //   }
  //
  //   else if(departmentDropMenu=='Network'){
  //
  //     if(gradeDropMenu=='First'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else if(gradeDropMenu=='Second'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else if(gradeDropMenu=='Third'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else {
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //
  //   }
  //
  //   else {
  //
  //     if(gradeDropMenu=='First'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else if(gradeDropMenu=='Second'){
  //       texts =[
  //         'Image Processing',
  //         'compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else if(gradeDropMenu=='Third'){
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //     else {
  //       texts =[
  //         'Image Processing',
  //         'Compiler',
  //         'Network',
  //         'Simulation',
  //         'NLP',
  //         'Security',
  //         'Cloud',
  //         'Distribution',
  //         'Theory of Compilation',
  //         'Project',
  //         'Cloud',
  //         'Distribution',
  //       ];
  //
  //     }
  //
  //   }
  //
  //
  //
  // }

  String url= "";


  Future getPdf({
    required String title,
    int index=0,
  })async{

    FilePickerResult ?result=await FilePicker.platform.pickFiles();
    File pick= File(result!.files.single.path.toString());
    var file =pick.readAsBytesSync();
    String name =DateTime.now().millisecondsSinceEpoch.toString();

    // upload to firebase

    var pdfFile =  FirebaseStorage.instance.ref().child(CashHelper.getData(key: 'departmentDrop'))
        .child(CashHelper.getData(key: 'gradeDrop'))
        .child(CashHelper.getData(key: 'type'))
        .child(title)
         .child('${index+1}');

    UploadTask task= pdfFile.putData(file);
    TaskSnapshot snapshot=await task;
    url = await snapshot.ref.getDownloadURL();

    MaterialModel materialModel=MaterialModel(
      title: title,
      url: url,
    );

    if(departmentDropMenu=='General'){
      if(gradeDropMenu=='First'){
        await FirebaseFirestore.instance.collection('General')
            .doc('grade1').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });

      }
      else if (gradeDropMenu=='Second'){
        await FirebaseFirestore.instance.collection('General')
            .doc('grade2').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else if (gradeDropMenu=='Third'){
        await FirebaseFirestore.instance.collection('General')
            .doc('grade3').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else{
        await FirebaseFirestore.instance.collection('General')
            .doc('grade4').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
    }
    else if(departmentDropMenu=='Medical'){
      if(gradeDropMenu=='First'){
        await FirebaseFirestore.instance.collection('Medical')
            .doc('grade1').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else if (gradeDropMenu=='Second'){
        await FirebaseFirestore.instance.collection('Medical')
            .doc('grade2').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else if (gradeDropMenu=='Third'){
        await FirebaseFirestore.instance.collection('Medical')
            .doc('grade3').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else{
        await FirebaseFirestore.instance.collection('Medical')
            .doc('grade4').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
    }
    else if(departmentDropMenu=='Security'){
      if(gradeDropMenu=='First'){
        await FirebaseFirestore.instance.collection('Security')
            .doc('grade1').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else if (gradeDropMenu=='Second'){
        await FirebaseFirestore.instance.collection('Security')
            .doc('grade2').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else if (gradeDropMenu=='Third'){
        await FirebaseFirestore.instance.collection('Security')
            .doc('grade3').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else{
        await FirebaseFirestore.instance.collection('Security')
            .doc('grade4').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
    }
    else{
      if(gradeDropMenu=='First'){
        await FirebaseFirestore.instance.collection('Network')
            .doc('grade1').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else if (gradeDropMenu=='Second'){
        await FirebaseFirestore.instance.collection('Network')
            .doc('grade2').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else if (gradeDropMenu=='Third'){
        await FirebaseFirestore.instance.collection('Network')
            .doc('grade3').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
      else{
        await FirebaseFirestore.instance.collection('Network')
            .doc('grade4').collection('Material').doc(title).collection('lecture').doc('${lecture.length+1}')
            .set(materialModel.toMap()).then((value) {
          print('Upload Success');
          emit(UploadPDFSuccessState());
        });
      }
    }

    emit(GetPDFState());
  }


  String gradeDropMenu='';
  String departmentDropMenu='';

  void setDepartmentDrop(value){
    departmentDropMenu=value;
    CashHelper.saveData(key: 'departmentDrop',value: departmentDropMenu);
    emit(SetDepartmentDropState());
  }

  void setGradeDrop(value){
    gradeDropMenu=value;
    CashHelper.saveData(key: 'gradeDrop',value: gradeDropMenu);
    emit(SetGradeDropState());
  }





}