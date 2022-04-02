
import 'package:email_auth/email_auth.dart';
import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_cubit.dart';
import 'package:final_project/layoutes/homepage/home_bloc/app_states.dart';
import 'package:final_project/modules/register/registercubit/bloc.dart';
import 'package:final_project/modules/register/registercubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:lottie/lottie.dart';



class EmailVerified extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>RegisterCubit(),
       child: BlocConsumer<RegisterCubit,RegisterStates>(
        listener: (context,state){

        },
      builder: (context,state){
          var cubit=RegisterCubit.get(context);
          cubit.otpController.text=cubit.emailValue!;
          return Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * .28,
                        height: MediaQuery.of(context).size.height * .20,
                        child: const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/icon 6.png'),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 100,
                      left:MediaQuery.of(context).size.width*.21,
                      child: Lottie.asset('assets/images/email.json',
                          height: 200
                      ),),
                    Positioned(
                      top: 300,
                      left: MediaQuery.of(context).size.width*.27,
                      child: Text('Please Send OTP and ',style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                      ),
                    ),
                    Positioned(
                      top: 325,
                      left: MediaQuery.of(context).size.width*.19,
                      child: Text('Enter OTP sent to your email',style: GoogleFonts.lato(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Positioned(
                      top: 370,
                      left: 0,
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(17, 0, 5, 0),
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                   controller: cubit.otp1Controller,
                                   textAlign: TextAlign.center,
                                   style: TextStyle(
                                     fontWeight: FontWeight.bold,
                                     fontSize: 22,
                                     color: mainColorDark,
                                   ),
                                  keyboardType: TextInputType.number,
                                ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  controller: cubit.otp2Controller,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: mainColorDark,
                                  ),
                                  keyboardType: TextInputType.number,
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  controller: cubit.otp3Controller,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: mainColorDark,
                                  ),
                                  keyboardType: TextInputType.number,
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  controller: cubit.otp4Controller,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: mainColorDark,
                                  ),
                                  keyboardType: TextInputType.number,
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  controller: cubit.otp5Controller,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: mainColorDark,
                                  ),
                                  keyboardType: TextInputType.number,
                                )
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                            child: Container(
                                alignment: Alignment.center,
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.white,
                                ),
                                child: TextFormField(
                                  controller: cubit.otp6Controller,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 22,
                                    color: mainColorDark,
                                  ),
                                  keyboardType: TextInputType.number,
                                )
                            ),
                          ),

                        ],
                      ),
                    ),
                    Positioned(
                        top: MediaQuery.of(context).size.height * 0.63,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(25, 0, 25, 15),
                            height: cubit.height,
                            width: MediaQuery.of(context).size.width * 1,
                            child: TextFormField(
                              controller: cubit.otpController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none
                                )
                              ),
                              style: const TextStyle(
                                color: Colors.white
                              ),
                            )
                        )),
                    cubit.isVerify?
                    Positioned(
                        top: 520,
                        left: MediaQuery.of(context).size.width*.35,
                        child:MaterialButton(
                          color: mainColorButton,
                          padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          onPressed: (){
                            cubit.VerifyOtp(context);
                          },
                          child: Text('Verify',style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),),
                        )
                    )
                    :Positioned(
                      top: 520,
                      left: MediaQuery.of(context).size.width*.3,
                      child:MaterialButton(
                          color: Colors.red,
                          padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                          ),
                          onPressed: (){
                            cubit.SendOtp();
                          },
                          child: Text('Send OTP',style: GoogleFonts.lato(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),),
                        ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: MediaQuery.of(context).size.width * .26,
                        height: MediaQuery.of(context).size.height * .18,
                        child: const Image(
                          fit: BoxFit.cover,
                          image: AssetImage('assets/images/icon 4.png'),
                        ),
                      ),
                    ),

                  ],
                ),

              ),
            ),

          );
      },
       ),
    );
  }
}
