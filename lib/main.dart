// @dart=2.9
import 'package:final_project/layoutes/homepage/container_screen.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/login/login_screen.dart';
import 'package:final_project/shared/Componant/Constants.dart';
import 'package:final_project/shared/local/cash_helper.dart';
import 'package:final_project/shared/local/diohelper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'firebase_options.dart';
import 'modules/chatScreen/chat_screen.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await CashHelper.init();
  await DioHelper.init();
  uId = CashHelper.getData(key: 'uId');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..getUserData()..getHomePost()..getMaterialTitles()..getGroupPosts(),
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context,state){},
        builder: (context,state){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.blue,
              scaffoldBackgroundColor: Colors.white,
              appBarTheme: const AppBarTheme(
                // systemOverlayStyle: SystemUiOverlayStyle(
                //   statusBarColor: Color.fromRGBO(11, 24, 82, .9),
                //   statusBarIconBrightness: Brightness.light,
                //   statusBarBrightness: Brightness.light
                // ),
                backgroundColor: Colors.white,
                elevation: 0.0,
              ),
              textTheme: GoogleFonts.nunitoSansTextTheme(
                Theme.of(context).textTheme,
              ),
            ),
            home: ChatScreen(),
          );
        },
      ),
    );
  }
}
