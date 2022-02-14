import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LecScreen extends StatelessWidget {

  String titleScreen='';

  LecScreen({
    required this.titleScreen
   });

  @override
  Widget build(BuildContext context) {
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
                    children: List.generate(12, (index) =>
                               Container(
                                 clipBehavior: Clip.antiAliasWithSaveLayer,
                                 decoration: BoxDecoration(
                                   borderRadius: BorderRadius.circular(10),
                                 ),
                                    child: Material(
                                      elevation: 20,
                                      color: Colors.grey.shade300,
                                      child: Column(
                                        children:  [
                                           const Image(
                                              image: NetworkImage(
                                                'https://img.freepik.com/free-photo/close-up-busy-businesswoman-writing_1098-3428.jpg?w=740'
                                              ),
                                          ),
                                          const SizedBox(height: 13,),
                                          Text('Lecture ${index+1}',style: const TextStyle(
                                            fontSize: 15,
                                          ),),
                                        ],
                                      ),
                                    ),
                                  ),

                    ),
                  ),
                ),
              ),

          ],
        ),
      )
    );
  }
}
