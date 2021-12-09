import 'package:final_project/constants/componts.dart';
import 'package:final_project/layoutes/homepage/container_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        leading:IconButton(
          onPressed: (){
            navigateTo(context, const ContainerScreen());
          },
          icon:const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text('My Profile',style: GoogleFonts.lato(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),),
        centerTitle: true,
      ),
      body: Container(
        child: Column(
          children: [
            const SizedBox(height: 8,),
            Material(
              elevation: 10,
              child: Container(
                margin: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                padding: const EdgeInsets.fromLTRB(20, 35, 20, 5),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(11, 24, 82, .9),
                  borderRadius: BorderRadius.circular(0),

                ),
                height: 250,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children:  [
                    const CircleAvatar(
                      radius: 48,
                      backgroundColor: Colors.white,
                      child: CircleAvatar(
                        radius: 45,
                        backgroundImage: AssetImage('assets/images/mine.png'),
                      ),
                    ),
                    const SizedBox(height: 15,),
                    Text('Mahmoud Reda',style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                    ),
                    const SizedBox(height: 10,),
                    Text('4th Level / CS Student',style: GoogleFonts.lato(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                    ),

                  ],
                ),
              ),
            ),
            const SizedBox(height: 5,),
            Expanded(
              child:ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>Block_Post(),
                  separatorBuilder: (context,index){
                    return  const SizedBox(height: 5,);
                  },
                  itemCount: 10
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Widget Block_Post(){
  return  Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
                  radius: 25,
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
                      fontSize: 15,
                    ),)
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 10,),
        Padding(
          padding: const EdgeInsets.fromLTRB(20,0, 10, 0),
          child: Text('By discovering nature, you discover yourself',
            style: GoogleFonts.lato(
              color: Colors.black,
              fontSize: 15,
            ),
          ),
        ),
        const SizedBox(height: 10,),
        const Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
          child: Image(
            image: NetworkImage(
                'https://image.freepik.com/free-photo/landscape-morning-fog-mountains-with-hot-air-balloons-sunrise_335224-794.jpg'
            ),
          ),
        ),
        const SizedBox(height: 5,),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  [
            const SizedBox(width: 12,),
            const Image(
                height: 25,
                width: 25,
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
                height: 24,
                width: 24,
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
        const SizedBox(height: 5,),
        Row(
          children:  [
            const SizedBox(width: 7,),
            const CircleAvatar(
              radius: 22,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/reda.jpeg'),
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
                height: 25,
                width: 25,
                image:
                AssetImage(
                  'assets/images/heart.png',
                )),
            const SizedBox(width: 5,),
            Text('Like',
              style: GoogleFonts.openSans(
                color: Colors.black,
                fontSize: 18,
              ),),
            const SizedBox(width: 10,),

          ],
        ),
        const SizedBox(height: 10,),

      ],

    ),
  );


}