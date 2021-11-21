

import 'package:final_project/constants/componts.dart';
import 'package:final_project/modules/login/logincubit/states.dart';
import 'package:final_project/modules/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logincubit/bloc.dart';

class LoginScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) =>LoginCubit(),
      child: BlocConsumer<LoginCubit, LoginStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = LoginCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              toolbarHeight: 0,
            ),
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Form(
                  key: cubit.loginKey,
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
                        top: MediaQuery.of(context).size.height * .06,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            navigateAndFinish(context, const RegisterScreen());
                          },
                          child: Container(
                            height: MediaQuery.of(context).size.height * .08,
                            width: MediaQuery.of(context).size.width * .27,
                            decoration: const BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                bottomLeft: Radius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Sign',
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                                Text(
                                  ' Up',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .21,
                        left: MediaQuery.of(context).size.width * .3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Text(
                              'Sign',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' In',
                              style: TextStyle(
                                color: Colors.blue,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),

                      Positioned(
                          top: MediaQuery.of(context).size.height * .34,
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 15),
                              height: cubit.height,
                              width: MediaQuery.of(context).size.width * 1,
                              child: dafaultFormField(
                                  label: 'Email',
                                  icon: const Icon(
                                    Icons.lock,
                                    color: Colors.black,
                                  ),
                                  controller: cubit.emailController,
                                  textInputType: TextInputType.emailAddress,
                                  textValidator: 'Please,enter correct email'))),
                      Positioned(
                          top: MediaQuery.of(context).size.height * .458,
                          child: Container(
                              padding: const EdgeInsets.fromLTRB(12, 0, 12, 15),
                              height: cubit.height,
                              width: MediaQuery.of(context).size.width * 1,
                              child: dafaultFormField(
                                label: 'Password',
                                icon: const Icon(
                                  Icons.lock,
                                  color: Colors.black,
                                ),
                                controller: cubit.passController,
                                textInputType: TextInputType.visiblePassword,
                                textValidator: 'Please,enter Password',
                                password: cubit.showPass,
                                suffixIcon: IconButton(
                                    icon:cubit.showPass?const Icon(Icons.visibility_off,color: Colors.black):const Icon(Icons.visibility,color: Colors.black),
                                    onPressed: (){
                                      cubit.showPassword();
                                    }
                                ),

                              ))),

                      Positioned(
                        top: MediaQuery.of(context).size.height * .58,
                        left: MediaQuery.of(context).size.width * .23,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            height: MediaQuery.of(context).size.height * .09,
                            width: MediaQuery.of(context).size.width * .55,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              color: Colors.blue,
                              child: const Text(
                                'Sign In',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                              onPressed: () {
                                cubit.formValidate(context);
                              },
                            )),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .74,
                        left: MediaQuery.of(context).size.width * .07,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          height: 2,
                          width: 100,
                          color: Colors.black87,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .73,
                        left: MediaQuery.of(context).size.width * .38,
                        child: const Text(
                          'Or Login With',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .74,
                        right: MediaQuery.of(context).size.width * .07,
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          height: 2,
                          width: 100,
                          color: Colors.black87,
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .78,
                        left: MediaQuery.of(context).size.width * .35,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                            child: Row(
                              children: [
                                Container(
                                  height: 35,
                                  child: const Image(
                                    image:
                                    AssetImage('assets/images/facebook.png'),
                                  ),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Container(
                                  height: 35,
                                  child: const Image(
                                    image: AssetImage('assets/images/search.png'),
                                  ),
                                ),
                              ],
                            )),
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
              // physics: const BouncingScrollPhysics(),
            ),
          );
        },
      ),
    );
  }
}
