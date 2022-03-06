import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class AddPost extends StatelessWidget {
  const AddPost({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return BlocConsumer <AppCubit , AppState>(

      listener: (context , state){},
      builder: (context , state){
        var postController=TextEditingController();
        var dateNow = DateTime.now();
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon:  Icon(
                Icons.arrow_back,
                color: mainColorButton,
              ),
            ),
            title: Text(
              'Create Post',
              style: TextStyle(
                color: mainColorDark,
                fontSize: 18,
                fontWeight: FontWeight.bold
              ),
            ),
            centerTitle: true,
            actions: [
              CircleAvatar(
                backgroundColor: mainColorButton,
                radius: 18,
                child: IconButton(
                  onPressed: (){
                    var dateNow = DateTime.now();
                    if(AppCubit.get(context).uploadedPostGroupImage == null)
                    {
                      AppCubit.get(context).createGroupPost(
                        postDate: dateNow.toString(),
                        postText : postController.text,
                        context: context
                      );
                    }
                    else{
                      AppCubit.get(context).createPostGroupWithImage(
                        postDate: dateNow.toString(),
                        postText : postController.text,
                        context: context,
                      );
                    }

                  },
                  icon: const Icon(
                    Icons.done,
                    size: 22,
                    color: Colors.white,
                  ),

                ),
              ),
              const SizedBox(width: 10,),

            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is CreatePostGroupSuccessState)
                  const SizedBox(
                    height: 10.0,
                  ),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 28.0,
                      backgroundImage: NetworkImage('${AppCubit.get(context).userModel!.image}'),
                    ),
                    const SizedBox(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppCubit.get(context).userModel!.fullName.toString(),
                            style: const TextStyle(
                              fontSize: 16.0,
                              fontWeight: FontWeight.w900,
                              height: 1.3,
                            ),
                          ),
                          const SizedBox(
                            height: 3.0,
                          ),
                          Text(dateNow.toString(),
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(
                              height: 1.3,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Expanded(
                  child: TextFormField(
                    controller: postController,
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                if(AppCubit.get(context).uploadedPostGroupImage != null)
                  Stack(
                    alignment: AlignmentDirectional.topEnd,
                    children: [
                      Container(
                        width: double.infinity,
                        child: Card(
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Image(
                            image: FileImage(AppCubit.get(context).uploadedPostGroupImage!),
                            fit: BoxFit.scaleDown,
                            height: 200.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                          left: 10.0,
                          right: 10.0,
                        ),
                        child: CircleAvatar(
                          radius: 20.0,
                          child: IconButton(
                            onPressed: () {
                              AppCubit.get(context).removePostGroupImage();
                            },
                            icon: const Icon(
                              Icons.close,
                              size: 18.0,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: (){
                          AppCubit.get(context).getPostGroupImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.photo_library_outlined,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              'Add Photo',
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        onPressed: (){},
                        child: const Text(
                          'Add File',
                          style: TextStyle(
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
