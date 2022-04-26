import 'package:final_project/modules/register/registercubit/bloc.dart';
import 'package:final_project/modules/register/registercubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class DoctorRegisterScreen extends StatelessWidget {
  const DoctorRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
      child: BlocConsumer <RegisterCubit , RegisterStates>(
        listener: (context, state) {},
        builder: (context , state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 1,
                  width: double.infinity,
                  child: Form(
                    key: cubit.registerKey,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 0,
                          left: 0,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .28,
                            height: MediaQuery.of(context).size.height * .20,
                            child: const Image(
                              fit: BoxFit.cover,
                              image: AssetImage('assets/images/icon 6.png'),
                            ),
                          ),
                        ),

                        Positioned(
                          top: MediaQuery.of(context).size.height*.21,
                          left: MediaQuery.of(context).size.width*.08,
                          child: Text('Add Subjects of this year',style: GoogleFonts.lato(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.bold
                          ),),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 200, 10, 10),
                              width: 150,
                              child: TextFormField(
                                decoration:  InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black,width: 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black,width: 1),
                                      borderRadius: BorderRadius.circular(10)

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 200, 10, 10),
                              width: 150,
                              child: TextFormField(
                                decoration:  InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black,width: 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black,width: 1),
                                      borderRadius: BorderRadius.circular(10)

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.fromLTRB(20, 290, 10, 10),
                              width: 150,
                              child: TextFormField(
                                decoration:  InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black,width: 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black,width: 1),
                                      borderRadius: BorderRadius.circular(10)

                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.fromLTRB(10, 290, 10, 10),
                              width: 150,
                              child: TextFormField(
                                decoration:  InputDecoration(
                                  border: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black,width: 1),
                                      borderRadius: BorderRadius.circular(10)
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(color: Colors.black,width: 1),
                                      borderRadius: BorderRadius.circular(10)

                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),



                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: SizedBox(
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
              ),
            ),
          );
        },
      ),
    );
  }
}
