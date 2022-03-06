import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../constants/componts.dart';
import '../../../layoutes/homepage/home_bloc/app_cubit.dart';
import '../../../layoutes/homepage/home_bloc/app_states.dart';
import '../../../models/materialModel.dart';
import '../../pdfReader/pdfReader.dart';

class LabScreen extends StatelessWidget {

  String titleScreen='';

  LabScreen({
    required this.titleScreen
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit , AppState>(
      listener: (context , state){},
      builder: (context , state){
        var cubit = AppCubit.get(context);
        List lectures = AppCubit.get(context).section;

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
                          cubit.section.length, (index) => lectureCard(cubit.section[index] , context),
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

  Widget lectureCard (MaterialModel lecture , context)
  {
    return InkWell(
      onTap: (){
        navigateTo(context, PdfReader(pdfUrl: lecture.url.toString() , title: lecture.title.toString(),));
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
                '${lecture.title}',
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
