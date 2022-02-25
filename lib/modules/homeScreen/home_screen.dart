import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/models/homeModel/home_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

    },
      builder: (context,state){
          return AppCubit.get(context).homeModel?.data!=null?
          Column(
            children: [
              const SizedBox(height: 5,),
              Expanded(
                child:ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context,index)=>Block_Post(AppCubit.get(context).homeModel!,index),
                    separatorBuilder: (context,index){
                      return  const SizedBox(height: 5,);
                    },
                    itemCount: AppCubit.get(context).dataLen!
                ),
              ),

            ],
          ):
          const Center(
            child: CircularProgressIndicator(),
          );
      },
    );
  }
}

Widget Block_Post(HomeModel model,index){
  String ?url= model.data[index].attributes?.image?.images[0].attributes?.url;
  String ?image=mainUrl! + url!;
  return  Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.fromLTRB(20,0,0,0),
          child: Row(
            children:  [
              const CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: CircleAvatar(
                  radius: 26,
                  backgroundImage: AssetImage('assets/images/reda.jpeg'),
                ),
              ),
              const SizedBox(width: 15,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Mahmoud Reda',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5,),
                  Text('2 weeks ago',
                    style: GoogleFonts.lato(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),)
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.fromLTRB(10,0, 15, 0),
          child: Text('${model.data[index].attributes?.describtion}',
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 15,
            ),
            textAlign: TextAlign.end,
          ),
        ),
        const SizedBox(height: 10,),
         Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Image(
            image: NetworkImage(
                image
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
            const SizedBox(width: 12,),
            const Image(
                height: 20,
                width: 20,
                image:
                AssetImage(
                  'assets/images/heart.png',
                )),
            const SizedBox(width: 5,),
            Text('23',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),),
            const Spacer(),
            const Image(
                height: 20,
                width: 20,
                image:
                AssetImage(
                  'assets/images/comment.png',
                )),
            const SizedBox(width: 5,),
            Text('6',
              style: GoogleFonts.lato(
                  color: Colors.black,
                  fontSize: 15,
                  fontWeight: FontWeight.bold
              ),),
            const SizedBox(width: 10,),
          ],

        ),
        const SizedBox(height: 10,),
        Container(
          margin: const EdgeInsets.fromLTRB(15, 0, 15, 0),
          height: 1,
          color: Colors.grey[300],
        ),
        const SizedBox(height: 8,),
        Row(
          children:  [
            const SizedBox(width: 7,),
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/mine.png'),
              ),
            ),
            const SizedBox(width: 15,),
            Text('Write a comment...',
              style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 15,
              ),),
            const Spacer(),
            const Image(
                height: 22,
                width: 22,
                image:
                AssetImage(
                  'assets/images/heart.png',
                )),
            const SizedBox(width: 5,),
            Text('Like',
              style: GoogleFonts.openSans(
                  color: Colors.black,
                  fontSize: 16,
              ),),
            const SizedBox(width: 10,),

          ],
        ),
        const SizedBox(height: 10,),

      ],

    ),
  );


}
