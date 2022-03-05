import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentScreen extends StatelessWidget {
  var commentController = TextEditingController();

  CommentScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
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
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context , index) => commentItem(),
                    separatorBuilder: (context , index) => const SizedBox(
                      height: 20.0,
                    ),
                    itemCount: 10,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18.0,
                        backgroundImage: NetworkImage(
                            '${AppCubit.get(context).userModel!.image}'
                        ),
                      ),
                      const SizedBox(
                        width: 10.0,
                      ),
                      Expanded(
                        child: Container(
                          height: 36.0,
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
                          commentController.text = '';
                        },
                        icon: const Icon(
                          Icons.send_rounded,
                          color: Colors.grey,
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


  Widget commentItem ()
  {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CircleAvatar(
                radius: 20.0,
                backgroundImage: NetworkImage(
                    'https://img.freepik.com/free-photo/headshot-pleased-hipster-has-satisfied-expression_273609-18229.jpg'
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
                    children: const [
                       Text(
                        'Mohamed Mmdouh Mohamed',
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w900,
                          height: 1.3,
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Text(
                        'Comment ',
                        style: TextStyle(
                          fontSize: 14.0,
                          fontWeight: FontWeight.w600,
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
