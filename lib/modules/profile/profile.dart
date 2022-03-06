import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/container_screen.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';
import '../../layoutes/homepage/home_bloc/app_states.dart';
import '../../models/PostModel.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        AppCubit.get(context).getUserData();
        AppCubit.get(context).getUserPosts();
        return BlocConsumer <AppCubit , AppState>(
          listener: (context , state) {},
          builder: (context , state) {
            var cubit = AppCubit.get(context);
            List <PostModel> myPosts = cubit.userPosts;
            return Scaffold(
              backgroundColor: Colors.grey[100],
              appBar: AppBar(
                elevation: 2,
                leading:IconButton(
                  onPressed: (){
                    navigateTo(context, const ContainerScreen());
                  },
                  icon:const Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                  ),
                ),
                title: Text(
                  'My Profile',
                  style: GoogleFonts.lato(
                    color: Colors.blue,
                    fontWeight: FontWeight.w900,
                    fontSize: 18,
                  ),
                ),
                centerTitle: true,
              ),
              body: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Container(
                  child: Column(
                    children: [
                      Material(
                        elevation: 10,
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          padding: const EdgeInsets.fromLTRB(20, 25 , 20, 5),
                          decoration: BoxDecoration(
                            color: const Color.fromRGBO(11, 24, 82, .9),
                            borderRadius: BorderRadius.circular(0),

                          ),
                          height: MediaQuery.of(context).size.height * 0.25,
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:  [
                               CircleAvatar(
                                radius: 48,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 45,
                                  backgroundImage: NetworkImage('${cubit.userModel!.image}'),
                                ),
                              ),
                              const SizedBox(height: 15,),
                              Text(
                                '${cubit.userModel!.fullName}',
                                style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                              ),
                              const SizedBox(height: 10,),
                              Text(
                                '${cubit.userModel!.bio}',
                                style: GoogleFonts.lato(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      ListView.separated(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context,index)=> postItem(myPosts[index], index),
                          separatorBuilder: (context,index){
                            return  const SizedBox(height: 10,);
                          },
                          itemCount: myPosts.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }
}


Widget postItem(PostModel model ,index ){
  return  Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,0,0,0),
          child: Row(
            children:  [
              CircleAvatar(
                radius: 26,
                backgroundImage: NetworkImage('${model.userImage}'),
              ),
              const SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.username}',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3,),
                  Text(
                    '${model.postDate}',
                    style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 11,
                    ),),
                ],
              ),
              const Spacer(),
              IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: Text(
              '${model.postText}',
              style: GoogleFonts.lato(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        model.postImage != null ?Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Image(
            image: NetworkImage(model.postImage!),
          ),
        ) : const SizedBox(height: 10,),
        const SizedBox(
          height: 5,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0,),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children:  [
              Text('23',
                style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),),
              const SizedBox(
                width: 4.0,
              ),
              Text('Like',
                style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 13,
                ),),
              const Spacer(),
              Text(
                '6',
                style: GoogleFonts.lato(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.bold
                ),
              ),
              const SizedBox(
                width: 4.0,
              ),
              Text(
                'Comment',
                style: GoogleFonts.lato(
                  color: Colors.grey,
                  fontSize: 13,
                ),
              ),
            ],

          ),
        ),
        const SizedBox(
          height: 10.0,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 12.0),
          height: 1,
          color: Colors.grey[300],
        ),
        Row(
          children:  [
            Expanded(
              child: IconButton(
                onPressed: (){},
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Icon(
                      LineIcons.heart,
                      size: 24.0,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'Like',
                      style: GoogleFonts.lato(
                        color: Colors.black54,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),),
            Expanded(
              child: IconButton(
                onPressed: (){},
                icon: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    const Icon(
                      LineIcons.comment,
                      size: 24.0,
                      color: Colors.black54,
                    ),
                    const SizedBox(
                      width: 4.0,
                    ),
                    Text(
                      'Comment',
                      style: GoogleFonts.lato(
                        color: Colors.black54,
                        fontSize: 14.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),),
          ],
        ),
      ],

    ),
  );

}