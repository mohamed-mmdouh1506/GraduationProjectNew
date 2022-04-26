import 'package:final_project/constants/componts.dart';
import 'package:final_project/constants/constants.dart';
import 'package:final_project/modules/login/login_screen.dart';
import 'package:final_project/modules/register/registercubit/bloc.dart';
import 'package:final_project/modules/register/registercubit/states.dart';
import 'package:final_project/modules/register/set_profile_register_screen.dart';
import 'package:final_project/shared/local/cash_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:line_icons/line_icons.dart';

class StudentRegisterScreen extends StatelessWidget {
  const StudentRegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = RegisterCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              toolbarHeight: 0,
            ),
            body: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
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
                        top: MediaQuery.of(context).size.height * .06,
                        right: 0,
                        child: InkWell(
                          onTap: () {
                            navigateAndFinish(context, LoginScreen());
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
                                  ' In',
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
                        top: MediaQuery.of(context).size.height * .16,
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
                              ' Up',
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
                        top: MediaQuery.of(context).size.height * .58,
                        left: MediaQuery.of(context).size.width * .1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'What\'s year you start in your faculty ?',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(vertical: 5.0 ,),
                                height: cubit.height,
                                width: MediaQuery.of(context).size.width * 0.50,
                                child: dafaultFormField(
                                  label: 'Start date',
                                  icon: const Icon(
                                    LineIcons.calendarAlt,
                                    color: Colors.black,
                                  ),
                                  controller: cubit.startDateController,
                                  textInputType: TextInputType.number,
                                  textValidator: 'Please, enter start date',
                                )),
                          ],
                        ),
                      ),

                      Positioned(
                        top: MediaQuery.of(context).size.height * .44,
                        left: MediaQuery.of(context).size.width * .1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'What is your grade ?',
                              style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                                padding: const EdgeInsets.symmetric(vertical: 5.0 ,),
                                height: MediaQuery.of(context).size.height * 0.07,
                                width: MediaQuery.of(context).size.width * 0.5,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                    color: Colors.black,
                                    width: 1,
                                  ),
                                  ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                  ),
                                  child: DropdownButton(
                                    dropdownColor: Colors.grey[300],
                                    elevation: 0,
                                    hint: RegisterCubit.get(context).dropDownValue1.isEmpty
                                        ? const Text('Grade', style: TextStyle(color: Colors.black, fontSize: 16.0 , fontWeight: FontWeight.bold),)
                                        : Text(
                                      RegisterCubit.get(context).dropDownValue1,
                                      style: const TextStyle(color: Colors.black , fontSize: 16.0, fontWeight: FontWeight.bold),
                                    ),
                                    isExpanded: true,
                                    iconSize: 30.0,
                                    style: const TextStyle(color: Colors.black , fontSize: 16.0 , fontWeight: FontWeight.bold),
                                    items: ['First', 'Second', 'Third' , 'Fourth'].map(
                                          (value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      },
                                    ).toList(),
                                    onChanged: (value) {
                                      RegisterCubit.get(context).changeDropDownValue1(value);
                                    },
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .30,
                        left: MediaQuery.of(context).size.width * .1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              'What is your Department ?',
                              style: GoogleFonts.nunitoSans(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 5.0 ,),
                              height: MediaQuery.of(context).size.height * 0.07,
                              width: MediaQuery.of(context).size.width * 0.5,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                border: Border.all(
                                  color: Colors.black,
                                  width: 1,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: DropdownButton(
                                  elevation: 0,
                                  hint: RegisterCubit.get(context).dropDownValue2.isEmpty
                                      ? const Text(
                                    'Department',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                    ),
                                  )
                                      : Text(
                                    RegisterCubit.get(context).dropDownValue2,
                                    style: const TextStyle(color: Colors.black , fontSize: 16.0, fontWeight: FontWeight.bold),
                                  ),
                                  dropdownColor: Colors.grey[300],
                                  isExpanded: true,
                                  iconSize: 30.0,
                                  style: const TextStyle(color: Colors.black , fontSize: 16.0 , fontWeight: FontWeight.bold),
                                  items: ['General', 'Security', 'Medical','Network'].map(
                                        (value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    },
                                  ).toList(),
                                  onChanged: (value) {
                                    RegisterCubit.get(context).changeDropDownValue2(value);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: MediaQuery.of(context).size.height * .77,
                        left: MediaQuery.of(context).size.width * .2,
                        child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                            height: MediaQuery.of(context).size.height * .063,
                            width: MediaQuery.of(context).size.width * .60,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              color: mainColorButton,
                              child: const Text(
                                'Next',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onPressed: () {
                                cubit.formValidate(context , const SetProfileRegister()).then((value) {
                                  CashHelper.putStartAt(key: 'startAt', value: cubit.startDateController.text);
                                  CashHelper.putGrade(key: 'grade', value: cubit.dropDownValue1);
                                  CashHelper.putStartAt(key: 'department', value: cubit.dropDownValue2);

                                });
                              },
                            )),
                      ),

                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .32,
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
