
import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/container_screen.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 6),(){

      return navigateAndFinish(context, const ContainerScreen());

    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
          toolbarHeight: 0.0,
          elevation: 0.0,
          backwardsCompatibility: false,
          systemOverlayStyle: SystemUiOverlayStyle(
              statusBarColor: mainColorDark,
              statusBarIconBrightness: Brightness.light
          )
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  mainColorDark,
                  mainColorLight
                ]
            ),
          ),
          height: double.infinity,
          alignment: Alignment.center,
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.18,),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Lottie.asset('assets/images/social.json',height: 300),
              )
            ],
          ),
        ),
      ),
    );
  }
}