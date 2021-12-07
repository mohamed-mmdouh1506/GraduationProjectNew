import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatelessWidget {
   Profile({Key? key}) : super(key: key);

  List <String> texts =[
    'Assembly',
    'Data Structure',
    'Logic',
    'Network',

  ];

  List <Color> colorsContainer =[
    const Color.fromRGBO(222, 186, 95, 1.0),
    const Color.fromRGBO(112, 130, 226, 1.0),
    const Color.fromRGBO(255, 139, 162, 1.0),
    const Color.fromRGBO(132, 234, 129, 1.0),

  ];

  List <Color> colorsItem =[
    const Color.fromRGBO(255, 185, 13, 1.0),
    const Color.fromRGBO(7, 38, 227, 1.0),
    const Color.fromRGBO(255, 13, 60, 1.0),
    const Color.fromRGBO(10, 236, 6, 1.0),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backwardsCompatibility: false,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
        ),
        backgroundColor: Colors.white,
         title:Text(
           'My Profile',style: GoogleFonts.lato(
           color: const Color.fromRGBO(11, 24, 82, 1),
           fontWeight: FontWeight.bold,
           fontSize: 17,
         ),
         ),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Color.fromRGBO(11, 24, 82, 1),
        ),
        actions: [
          IconButton(
            onPressed: (){

            },
            icon: const Icon(
              Icons.menu,
              color: Color.fromRGBO(11, 24, 82, 1),
            ),
          )
        ],

      ),
      body:  Container(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                padding: const EdgeInsets.fromLTRB(20, 15, 20, 5),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(11, 24, 82, .9),
                  borderRadius: BorderRadius.circular(20),

                ),
                height: 200,
                width: MediaQuery.of(context).size.width*.9,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    const CircleAvatar(
                      radius: 43,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                       radius: 40,
                       backgroundImage: AssetImage('assets/images/mine.png'),
                   ),
                    ),
                    const SizedBox(height: 15,),
                    Text('Mahmoud Reda',style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    ),
                    const SizedBox(height: 10,),
                    Text('4th Level / CS Student',style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                    ),

                  ],
                ),
              ),
              const SizedBox(height: 25,),
              Container(
                padding: const EdgeInsets.fromLTRB(20,0, 10, 10),
                child: Row(
                  children: [
                    Text('My Courses',style: GoogleFonts.lato(
                      color:const Color.fromRGBO(11, 24, 82, 1),
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width*.38,),
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(
                          Icons.menu,
                          color:Color.fromRGBO(11, 24, 82, 1),
                          size:23 ,
                      ),
                    ),
                    IconButton(
                        onPressed: (){},
                        icon: const Icon(
                          Icons.arrow_forward_ios,
                          color:Color.fromRGBO(11, 24, 82, 1),
                          size:23 ,

                        ),
                    ),

                  ],
                ),
              ),
              Expanded(
                child: GridView.count(
                    crossAxisCount: 2,
                     physics: const BouncingScrollPhysics(),
                     crossAxisSpacing: 0,
                  mainAxisSpacing: 0,
                  childAspectRatio: 1/.7,
                  children: List.generate(4, (index) =>Block_Materials(texts[index], colorsContainer[index], colorsItem[index]) ),


                ),
              ),
            ],
          ),
        ),
    );
  }
}

Widget Block_Materials(String text,Color colorContainer,Color colorItem){
  return Container(
    margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
    padding: const EdgeInsets.fromLTRB(15, 10, 10, 5),

    decoration:  BoxDecoration(
      color: Colors.grey[300],
      borderRadius: BorderRadius.circular(25),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            IconButton(
                onPressed: (){},
                icon:  Icon(
                  Icons.file_copy_rounded,
                  color: colorItem,
                  size: 40,
                )
            ),
            Spacer(),
            IconButton(
                onPressed: (){},
                icon: const Icon(
                  Icons.menu,
                  color: Colors.black,
                )
            ),
          ],
        ),
        SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
          child: Text(text,style: GoogleFonts.lato(
            color: colorItem,
            fontWeight: FontWeight.bold,
            fontSize: 19,
          ),),
        )
      ],
    ),
  );
}
