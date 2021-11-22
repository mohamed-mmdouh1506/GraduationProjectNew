import 'package:final_project/modules/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var onBoardingController = PageController();
  bool isLast = false;

  @override
  Widget build(BuildContext context) {

    List<OnBoardingModel> onBoardingItems =
    [
      OnBoardingModel(
          image: 'assets/images/onboard1.png',
          title: 'onBoarding Screen 1',
          body: 'onBoarding body 1',
      ),
      OnBoardingModel(
        image: 'assets/images/onboard2.png',
        title: 'onBoarding Screen 2',
        body: 'onBoarding body 2',
      ),
      OnBoardingModel(
        image: 'assets/images/onboard3.png',
        title: 'onBoarding Screen 3',
        body: 'onBoarding body 3',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onBoarding_background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context , index) => onBoardingItem(context , onBoardingItems[index]),
                itemCount: onBoardingItems.length,
                controller: onBoardingController,
                onPageChanged: (index){
                  setState(() {
                    if(index == onBoardingItems.length -1)
                    {
                      isLast = true;
                    }
                    else{
                      isLast = false;
                    }
                  });
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0 , vertical: 10.0),
              child: Row(
                children: [
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context){
                          return LoginScreen();
                        }));
                      },
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: SmoothPageIndicator(
                        controller: onBoardingController,
                        count: onBoardingItems.length,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 10.0,
                          dotWidth: 10.0,
                          expansionFactor: 4,
                          dotColor: Colors.white,
                          spacing: 5.0,
                        ),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: (){
                      if(isLast == true)
                        {
                          Navigator.push(context, MaterialPageRoute(builder: (context){
                            return LoginScreen();
                          }));
                        }
                      else{
                        onBoardingController.nextPage(
                          duration: const Duration(
                            milliseconds: 800,
                          ),
                          curve: Curves.fastLinearToSlowEaseIn,
                        );
                      }
                    },
                    child: const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget onBoardingItem (context , OnBoardingModel model)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.03),
          child: Container(
            alignment: Alignment.topCenter,
            child: Image(
              image: AssetImage(model.image),
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height*0.14,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title,
                style: const TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height*0.03,
              ),
              Text(
                model.body,
                style: const TextStyle(
                  fontSize: 16.0,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class OnBoardingModel{
  String image;
  String title;
  String body;

  OnBoardingModel({
    required this.image ,
    required this.title ,
    required this.body,
  });
}
