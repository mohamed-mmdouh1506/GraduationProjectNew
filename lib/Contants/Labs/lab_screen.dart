import 'package:flutter/material.dart';

class LabScreen extends StatelessWidget {

  String titleScreen='';

  LabScreen({
    required this.titleScreen
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 5,
        iconTheme: const IconThemeData(
          color: Colors.black
        ),
        title: Text(
            titleScreen,style: const TextStyle(
            color: Colors.black
        ),
        ),
      ),
      body:  Column(
        children: [
          Expanded(
            child: Container(
              margin: const EdgeInsets.all(10),

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
                        color: Colors.grey[300],
                        child: Column(
                          children:  [
                            const Image(
                              image: NetworkImage(
                                  'https://img.freepik.com/free-vector/webinar-concept-illustration_114360-4764.jpg?w=740'
                              ),
                            ),
                            const SizedBox(height: 13,),
                            Text('Section ${index+1}',style: const TextStyle(
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
    );
  }
}
