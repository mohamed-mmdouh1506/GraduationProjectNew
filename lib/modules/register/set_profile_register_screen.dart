import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/modules/login/login_screen.dart';
import 'package:final_project/modules/register/registercubit/bloc.dart';
import 'package:final_project/modules/register/registercubit/states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';

class SetProfileRegister extends StatelessWidget {
  const SetProfileRegister({Key? key}) : super(key: key);

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
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20.0),
                          child: Align(
                            alignment: AlignmentDirectional.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Stack(
                                  alignment: AlignmentDirectional.bottomEnd,
                                  children:  [
                                    CircleAvatar(
                                      backgroundImage: cubit.profile,
                                      radius: 80.0,
                                    ),
                                   Padding(
                                     padding: const EdgeInsets.symmetric(horizontal: 18.0),
                                     child: InkWell(
                                       onTap: (){
                                         cubit.getProfileImage();
                                       },
                                       child: Stack(
                                         alignment: AlignmentDirectional.center,
                                         children: [
                                           const CircleAvatar(
                                             backgroundColor: Colors.white,
                                             radius: 20.0,
                                           ),
                                           Container(
                                             width: 35.0,
                                             height: 35.0,
                                             decoration: BoxDecoration(
                                               color: Colors.blue,
                                               borderRadius: BorderRadius.circular(20.0),
                                             ),
                                             child: const Icon(
                                               Icons.camera_alt,
                                               color: Colors.white,
                                               size: 20.0,
                                             ),
                                           ),
                                         ],
                                       ),
                                     ),
                                   ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0 ,),
                                    height: MediaQuery.of(context).size.height * 0.09,
                                    width: MediaQuery.of(context).size.width * 1,
                                    child: dafaultFormField(
                                        label: 'Full Name',
                                        icon: const Icon(
                                            LineIcons.user,
                                            color: Colors.black,
                                        ),
                                        controller: cubit.setNameController,
                                        textInputType: TextInputType.name,
                                        textValidator: 'Please, enter your name',
                                    ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.012,
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 10.0 ,vertical: 5.0),
                                  height: MediaQuery.of(context).size.height * 0.1,
                                  width: MediaQuery.of(context).size.width * 1,
                                  child: dafaultFormField(
                                    label: 'Bio',
                                    icon: const Icon(
                                      LineIcons.bookmark,
                                      color: Colors.black,
                                    ),
                                    controller: cubit.setBioController,
                                    textInputType: TextInputType.name,
                                    textValidator: 'Please, enter your Bio',
                                  ),
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * 0.05,
                                ),
                                cubit.checkRegister==false?
                                const Center(
                                  child: CircularProgressIndicator(),
                                ):Container(
                                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    height: MediaQuery.of(context).size.height * .063,
                                    width: MediaQuery.of(context).size.width * .60,
                                    child: MaterialButton(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      color: mainColorButton,
                                      child: const Text(
                                        'Register',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      onPressed: () {
                                        cubit.formValidate(context,LoginScreen()).then((value){
                                           cubit.checkRegister=false;
                                        });

                                      },
                                    )),

                              ],
                            ),
                          ),
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
