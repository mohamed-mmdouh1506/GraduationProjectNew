import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Test extends StatefulWidget {
  @override
  _ScrollingAnimation3WidgetState createState() => _ScrollingAnimation3WidgetState();
}

class _ScrollingAnimation3WidgetState extends State<Test> {
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: CustomScrollView(
          shrinkWrap: true,
          controller: controller,
          slivers: <Widget>[
            SliverPersistentHeader(
              pinned: true,
              delegate: itemBlock(),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  const SizedBox(height: 15,),
                  SizedBox(
                    height: 1200,
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        itemBuilder: (context,index)=>Block_Post(),
                        separatorBuilder: (context,index){
                          return  const SizedBox(height: 10,);
                        },
                        itemCount: 50
                    ),
                  )


                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
}

const maxHeader=200.0;
const minHeader=90.0;

const maxImageSize=160.0;
const minImageSize=60.0;

const maxTitleSize=16.0;
const minTitleSize=12.0;

const maxSubTitleSize=14.0;
const minSubTitleSize=10.0;

class itemBlock extends SliverPersistentHeaderDelegate{
  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    final present= shrinkOffset /maxImageSize;
    final size=MediaQuery.of(context).size;
    final currentImageSize= (maxImageSize*(1-present)).clamp(minImageSize, maxImageSize);
    final currentTitleSize= (maxTitleSize*(1-present)).clamp(minTitleSize, maxTitleSize);
    final currentSubTitleSize= (maxSubTitleSize*(1-present)).clamp(minSubTitleSize, maxSubTitleSize);

    return Container(
      color: const Color.fromRGBO(11, 24, 82, .9),
      child: Stack(
        children:  [
          // Positioned(
          //   height: maxImageSize,
          //   top: 60,
          //   left: size.width/7 *(present/8),
          //   child: Container(
          //     padding: EdgeInsets.only(left: 120),
          //     child: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text('Mahmoud Reda',style: TextStyle(
          //           fontSize: currentTitleSize,
          //           color: Colors.white
          //         ),),
          //         Text('4th Level / CS Student',style: GoogleFonts.lato(
          //           color: Colors.white,
          //           fontWeight: FontWeight.bold,
          //           fontSize: currentSubTitleSize,
          //         ),)
          //
          //       ],
          //     ),
          //   )
          // ),
          Positioned(
              height: currentImageSize,
              bottom: 10,
              left: size.width/4*(present/2000),
              child: Container(
                  margin: const EdgeInsets.only(left: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const CircleAvatar(
                        radius: 40,
                        backgroundImage: AssetImage('assets/images/reda.jpeg'),
                      ),
                      const SizedBox(width: 15,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Mahmoud Reda',style: TextStyle(
                              fontSize: currentTitleSize,
                              color: Colors.white
                          ),),
                          Text('4th Level / CS Student',style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),)
                        ],
                      )


                    ],
                  )
              )

          ),

        ],
      ),
    );
  }

  @override
  double get maxExtent => maxHeader;

  @override
  double get minExtent => minHeader;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) => false;
}



Widget Block_Post(){
  return  Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
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
                height: 24,
                width: 24,
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
                height: 24,
                width: 24,
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