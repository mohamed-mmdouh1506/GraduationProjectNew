import 'package:final_project/layoutes/homepage/container_screen.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/analysisScreen/analysis_screen.dart';
import 'package:final_project/modules/login/login_screen.dart';
import 'package:final_project/modules/messageScreen/message_screen.dart';
import 'package:final_project/modules/onboardingScreen/onboarding_screen.dart';
import 'package:final_project/modules/profile/profile.dart';
import 'package:final_project/modules/register/setProfileRegisterScreen.dart';
import 'package:final_project/modules/welcomeScreen/welcomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>AppCubit(),
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context,state){

        },
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                elevation: 0.0,
                backwardsCompatibility: false,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark
                )
              ),
              textTheme: GoogleFonts.nunitoSansTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: const WelcomeScreen(),
          );
        },
      ),
    );
  }
}
