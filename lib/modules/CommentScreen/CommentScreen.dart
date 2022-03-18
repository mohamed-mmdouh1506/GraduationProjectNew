import 'package:conditional_builder/conditional_builder.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/models/CommentModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class CommentScreen extends StatelessWidget {
  var commentController = TextEditingController();
  String? postId;
  String? route;
  CommentScreen({Key? key , this.postId , this.route}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        switch (route)
        {
          case 'home' : {
            AppCubit.get(context).getHomeComments(postId!);
            break;
          }
          case 'group' : {
            AppCubit.get(context).getGroupComments(postId: postId!);
            break;
          }
        }
        return BlocConsumer <AppCubit , AppState> (
          listener: (context , state) {},
          builder: (context , state) {
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  'Comments',
                  style: GoogleFonts.lato(
                    color: Colors.blue,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
                leading: IconButton(
                  onPressed: (){
                    AppCubit.get(context).homeComments = [];
                    AppCubit.get(context).groupComments = [];
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.blue,
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Column(
                  children: [
                    Expanded(
                      child: ConditionalBuilder(
                          condition:  AppCubit.get(context).homeComments.length != 0 ||  AppCubit.get(context).groupComments != 0,
                          builder: (context ) => ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context , index) => commentItem(route == 'home' ? AppCubit.get(context).homeComments[index] : AppCubit.get(context).groupComments[index]),
                            separatorBuilder: (context , index) => const SizedBox(
                              height: 20.0,
                            ),
                            itemCount: route == 'home' ? AppCubit.get(context).homeComments.length : AppCubit.get(context).groupComments.length,
                          ),
                          fallback: (context ) => Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  LineIcons.comment,
                                  size: 100.0,
                                  color: Colors.grey[300],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Add Comment',
                                  style: GoogleFonts.lato(
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.grey[300],
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 22.0,
                            backgroundImage: NetworkImage(
                                '${AppCubit.get(context).userModel!.image}'
                            ),
                          ),
                          const SizedBox(
                            width: 10.0,
                          ),
                          Expanded(
                            child: Container(
                              height: 42.0,
                             // color: backgroundColor: Colors.grey.shade100,,
                              alignment: Alignment.centerLeft,
                              padding: const EdgeInsets.symmetric(horizontal: 18.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.grey[200],
                              ),
                              child: TextField(
                                decoration: const InputDecoration(
                                  hintText: 'Write a comment...',
                                  border: InputBorder.none,
                                ),
                                controller: commentController,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: (){
                              if(route == 'home')
                                {
                                  AppCubit.get(context).commentHomePost(postId!, commentController.text);
                                }
                              else if (route == 'group')
                                {
                                  AppCubit.get(context).commentGroupPost(postId!, commentController.text);
                                }
                              commentController.text = '';
                            },
                            icon: const Icon(
                              Icons.send_rounded,
                              color: Colors.grey,
                              size: 34.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }


  Widget commentItem (CommentModel model)
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    '${model.userImage}'
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(
                    top: 5.0,
                    bottom: 10.0,
                    left: 15.0,
                    right: 15.0,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children:  [
                       Text(
                        '${model.username}',
                        style: const TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.w900,
                          height: 1.3,
                        ),
                      ),
                      const SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        '${model.comment}',
                        style: const TextStyle(
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


}
