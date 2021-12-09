import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class MaterialScreen extends StatelessWidget {
  MaterialScreen({Key? key}) : super(key: key);

  List <String> texts =[
    'Assembly',
    'Data Structure',
    'Logic Design',
    'Network',
    'Compiler',
    'Introduction',

  ];

  List <Color> colorsContainer =[
    const Color.fromRGBO(253, 242, 209, 1.0),
    const Color.fromRGBO(195, 198, 252, 0.7647058823529411),
    const Color.fromRGBO(253, 198, 208, 1.0),
    const Color.fromRGBO(199, 255, 241, 1.0),
    const Color.fromRGBO(241, 198, 253, 1.0),
    const Color.fromRGBO(248, 203, 184, 1.0),
  ];

  List <Color> colorsItem =[
    Colors.amber,
    Colors.blueAccent,
    const Color.fromRGBO(255, 13, 60, 1.0),
    const Color.fromRGBO(0, 199, 205, 1.0),
    const Color.fromRGBO(211, 13, 255, 1.0),
    const Color.fromRGBO(255, 78, 2, 1.0),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:  Container(
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 20, 10, 20),
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
            const SizedBox(height: 10,),
            Container(
              padding: const EdgeInsets.fromLTRB(20,0, 10, 10),
              child: Row(
                children: [
                  Text('My Courses',style: GoogleFonts.lato(
                    color:Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(
                      Icons.menu,
                      color:Colors.black,
                      size:23 ,
                    ),
                  ),
                  IconButton(
                    onPressed: (){},
                    icon: const Icon(
                      Icons.arrow_forward_ios,
                      color:Colors.black,
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
                children: List.generate(colorsContainer.length, (index) =>Block_Materials(texts[index], colorsContainer[index], colorsItem[index]) ),


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
      color: colorContainer,
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
                icon: Icon(
                  Icons.menu,
                  color: colorItem,
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
