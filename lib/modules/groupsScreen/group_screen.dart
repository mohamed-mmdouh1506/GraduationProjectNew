
import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/models/groupModel/group_model.dart';
import 'package:final_project/models/userModel/user_model.dart';
import 'package:final_project/modules/addPost/add_post.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

import '../CommentScreen/CommentScreen.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=AppCubit.get(context);
        return state is GetPostGroupLoadingState?
            const Center(child: CircularProgressIndicator()):
            Scaffold(
              backgroundColor: Colors.grey.shade100,
              body: RefreshIndicator(
                onRefresh: cubit.refreshData,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 8,),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Material(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: RoundedRectangleBorder(
                          ),
                          child: Image(
                            image: NetworkImage('https://scontent.fcai21-2.fna.fbcdn.net/v/t1.6435-9/67887885_10156118881301097_5919966737922523136_n.jpg?_nc_cat=107&ccb=1-5&_nc_sid=8631f5&_nc_ohc=i22D375c4dMAX90DYXG&_nc_ht=scontent.fcai21-2.fna&oh=00_AT9y92XdI9dCIdzMsS-08YPQgDjcJgSYoCDhB1M99z7QjA&oe=6246342F'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5,),
                      ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context,index)=> postItem(cubit.groupPosts[index], index, context),
                          separatorBuilder: (context,index){
                            return  const SizedBox(height: 5,);
                          },
                          itemCount: cubit.groupPosts.length,
                        ),
                    ],
                 ),
                ),
              ),
              floatingActionButton:FloatingActionButton(
                backgroundColor: Colors.blue,
                onPressed:(){
                    navigateTo(context, const AddPost());
                },
                child: const Icon(LineIcons.pen),
              ),
            );
      },
    );
  }
}

Widget postItem(GroupModel model ,index  , context){
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
                backgroundImage: NetworkImage(model.userImage!),
              ),
              const SizedBox(width: 8,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.username!,
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 3,),
                  Text(
                    model.postDate!,
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
              model.postText!,
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
              Text('${AppCubit.get(context).groupLikes[index]}',
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
                '${AppCubit.get(context).groupCommentsNumber[index]}',
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
                onPressed: (){
                  AppCubit.get(context).likeGroupPost(AppCubit.get(context).groupPostsId[index]);
                },
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
                onPressed: (){
                  navigateTo(context, CommentScreen(postId: AppCubit.get(context).groupPostsId[index] , route: 'group',));
                },
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
