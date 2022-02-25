import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/pdfReader/pdfReader.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LecScreen extends StatelessWidget {

  String titleScreen='';

  LecScreen({
    required this.titleScreen
   });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = AppCubit.get(context);
        List lectures = AppCubit.get(context).material1;
        print(lectures.length);
        return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: const IconThemeData(
                  color: Colors.black
              ),
              elevation: 3,
              title: Text(
                titleScreen,
                style: const TextStyle(
                    color: Colors.black
                ),
              ),
            ),
            body: Container(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      child: GridView.count(
                        physics: const BouncingScrollPhysics(),
                        crossAxisCount: 2,
                        childAspectRatio: 1/.95,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        children: List.generate(
                          cubit.material1.length, (index) => lectureCard(cubit.material1[index] , context),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
        );
      },
    );
  }


  Widget lectureCard (Map lecture , context)
  {
    return InkWell(
      onTap: (){
        navigateTo(context, PdfReader(pdfUrl: "http://192.168.1.12:1337"+lecture['attributes']['lecture']['data'][0]['attributes']['url'] , title : lecture['attributes']['title']));
      },
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Material(
          elevation: 20,
          color: Colors.grey.shade300,
          child: Column(
            children: [
               const Image(
                image: NetworkImage(
                    'https://img.freepik.com/free-photo/close-up-busy-businesswoman-writing_1098-3428.jpg?w=740'
                ),
              ),
               const SizedBox(height: 13,),
               Text(
                 '${lecture['attributes']['title']}',
                 style:  const TextStyle(
                   fontSize: 15,
                 ),
               ),
            ],
          ),
        ),
      ),
    );
  }

}
