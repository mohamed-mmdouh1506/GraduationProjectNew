import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:intl/intl.dart';

class NewPost extends StatelessWidget {

  var postTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer <AppCubit , AppState>(
      listener: (context , state){},
      builder: (context , state){
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: (){
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.blue,
              ),
            ),
            title: const Text(
                'Create Post',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              TextButton(
                onPressed: (){
                  var dateNow = DateTime.now();
                  if(AppCubit.get(context).uploadedPostImage == null)
                    {
                      AppCubit.get(context).createPost(
                          postDate: '${DateFormat('EEE, d MMM y     hh:mm aaa').format(DateTime.now())}',
                          postText : postTextController.text,
                      );
                    }
                  else{
                    AppCubit.get(context).createPostWithImage(
                        postDate: '${DateFormat('EEE, d MMM y     hh:mm aaa').format(DateTime.now())}',
                        postText : postTextController.text,
                    );
                  }

                },
                child: const Text(
                  'Post',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                if(state is CreatePostLoadingState)
                  const LinearProgressIndicator(),
                if(state is CreatePostSuccessState)
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
                          Text(
                            'Public',
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
                    controller: postTextController,
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind....',
                      border: InputBorder.none,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                if(AppCubit.get(context).uploadedPostImage != null)
                  Stack(
                  alignment: AlignmentDirectional.topEnd,
                  children: [
                    Container(
                      width: double.infinity,
                      child: Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Image(
                          image: FileImage(AppCubit.get(context).uploadedPostImage!),
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
                            AppCubit.get(context).removePostImage();
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
                          AppCubit.get(context).getPostImage();
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
