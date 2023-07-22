import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:graduation_project/data/web_services/userinfowebservices.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:graduation_project/business_logic/cubit/app_cubit.dart';
import 'package:graduation_project/business_logic/cubit/surveys_cubit.dart';
import 'package:graduation_project/constants/strings.dart';
import 'package:graduation_project/data/models/User.dart';
import 'package:graduation_project/data/repository/avaliablesurveysrepository.dart';
import 'package:graduation_project/data/repository/userinforepository.dart';
import 'package:graduation_project/data/web_services/surveysavaliablewebservices.dart';
import 'package:graduation_project/presentation/widgets/sharedprefs.dart';

class LoginScreen extends StatelessWidget {
  AuthWebServices authWebServices = AuthWebServices();

  LoginScreen(
    Key? key,
    this.authRepository,
    this.avaliableSurveysRepository,
  ) : super(key: key);
  final formkey = GlobalKey();
  TextEditingController password = TextEditingController();
  TextEditingController username = TextEditingController();
  final AuthRepository authRepository;
  final AvaliableSurveysRepository avaliableSurveysRepository;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocConsumer<AppCubit, AppState>(
        listener: (context, state) async {
          if (state is UserInfoloading) {
            CircularProgressIndicator();
          }
          if (state is UserInfoloadingFailed) {
            AppCubit.get(context).un.text = AppCubit.get(context).username;
            AppCubit.get(context).username = "";
            AppCubit.get(context).pw.text = AppCubit.get(context).password;
            AppCubit.get(context).password = "";
            AwesomeDialog(
              context: context,
              dialogType: DialogType.error,
              title: "Invalid Email or Password ",
              // btnCancelOnPress: () {},
              // btnOkOnPress: () {})
            )..show();
          }

          if (state is UserInfoLoaded) {
            SharedPreferances sharedPreferances = SharedPreferances();
            final User user = AppCubit.get(context).user;
            await SurveysCubit.get(context).avalialesurveys(
                user!.data!.userID,
                user.data!.userTypeID!,
                user.data!.collegeID!,
                user.data!.levelID!,
                user.data!.depID!,
                user.data!.divID!,
                user.data!.gender!,
                0,
                0);
            await sharedPreferances.setint("UserID", user.data!.userID!);
            await sharedPreferances.setint(
                "UserTypeID", user.data!.userTypeID!);
            Navigator.pushReplacementNamed(context, home_screen);
          }
          if (state is UserLogOut) {
            Navigator.pushReplacementNamed(context, login_screen);
            AppCubit.get(context).un.text = "";
            AppCubit.get(context).pw.text = "";
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.33,
                    child: Image.asset(
                      'assets/images/psu.png',
                      fit: BoxFit.cover,
                      excludeFromSemantics: true,
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Form(
                    key: formkey,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        children: [
                          TextFormField(
                            onChanged: (val) {
                              // print(val);
                              AppCubit.get(context).username = val;
                            },
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your name';
                              }
                            },
                            controller: state is TextApearstate ||
                                    state is DarkModestate ||
                                    state is UserInfoloadingFailed
                                ? AppCubit.get(context).un
                                : username,
                            decoration: InputDecoration(
                                prefixIcon: const Icon(Icons.person,
                                    color: Colors.grey),
                                hintText: "Email",
                                errorStyle: const TextStyle(
                                    color: Colors.blue, fontSize: 15),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      width: 2,
                                    ),
                                    gapPadding: 20),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20),
                                    borderSide: BorderSide(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .tertiary,
                                      width: 2,
                                    ),
                                    gapPadding: 20)),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            onChanged: (val) {
                              // print(val);
                              AppCubit.get(context).password = val;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'passWord mustn`t be empty';
                              }
                            },
                            keyboardType: TextInputType.name,
                            obscureText: AppCubit.get(context).textappear,
                            textInputAction: TextInputAction.done,
                            controller: state is TextApearstate ||
                                    state is DarkModestate ||
                                    state is UserInfoloadingFailed
                                ? AppCubit.get(context).pw
                                : password,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: () {
                                  AppCubit.get(context).textAppear();
                                },
                                icon: Icon(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  AppCubit.get(context).textappear
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                              ),
                              prefixIcon:
                                  const Icon(Icons.lock, color: Colors.grey),
                              hintText: "Password",
                              errorStyle: const TextStyle(
                                  color: Colors.blue, fontSize: 15),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color:
                                        Theme.of(context).colorScheme.tertiary,
                                    width: 2,
                                  ),
                                  gapPadding: 20),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide(
                                  color: Theme.of(context).colorScheme.tertiary,
                                  width: 2,
                                ),
                                gapPadding: 20,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          TextButton(
                              onPressed: () {
                                if (state is TextApearstate ||
                                    state is DarkModestate ||
                                    state is UserInfoloadingFailed) {
                                  AvaliableSurveys().surveydetails(1);
                                  if (AppCubit.get(context).un.text.isEmpty &&
                                      AppCubit.get(context)
                                          .pw
                                          .text
                                          .isNotEmpty) {
                                    AppCubit.get(context).pw.text =
                                        AppCubit.get(context).password;

                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        title: "must enter email",
                                        autoHide: Duration(seconds: 2))
                                      ..show();
                                  } else if (AppCubit.get(context)
                                          .pw
                                          .text
                                          .isEmpty &&
                                      AppCubit.get(context)
                                          .un
                                          .text
                                          .isNotEmpty) {
                                    AppCubit.get(context).un.text =
                                        AppCubit.get(context).username;
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        title: "must enter password",
                                        autoHide: Duration(seconds: 2))
                                      ..show();
                                  } else if (AppCubit.get(context)
                                          .un
                                          .text
                                          .isEmpty &&
                                      AppCubit.get(context).pw.text.isEmpty) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        title: "No Email or Password entered",
                                        autoHide: Duration(seconds: 2))
                                      ..show();
                                  } else {
                                    AppCubit.get(context).getuserinfo(
                                        AppCubit.get(context).un.text,
                                        AppCubit.get(context).pw.text,
                                        context);
                                    CircularProgressIndicator();
                                  }
                                } else {
                                  if (username!.text.isEmpty &&
                                      password!.text.isNotEmpty) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        title: "must enter email",
                                        autoHide: Duration(seconds: 2))
                                      ..show();
                                  } else if (password!.text.isEmpty &&
                                      username!.text.isNotEmpty) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        title: "must enter password",
                                        autoHide: Duration(seconds: 2))
                                      ..show();
                                  } else if (password!.text.isEmpty &&
                                      username!.text.isEmpty) {
                                    AwesomeDialog(
                                        context: context,
                                        dialogType: DialogType.error,
                                        title: "No Email or Password entered",
                                        autoHide: Duration(seconds: 2))
                                      ..show();
                                  } else {
                                    AppCubit.get(context).getuserinfo(
                                        AppCubit.get(context).username,
                                        AppCubit.get(context).password,
                                        context);
                                    CircularProgressIndicator();
                                  }
                                }
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 6, 77, 135),
                                    borderRadius: BorderRadius.circular(20)),
                                padding: EdgeInsets.only(
                                    right: 20, left: 20, bottom: 10, top: 10),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                ),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding: EdgeInsets.only(left: 80),
                            child: Row(
                              children: [
                                Text("Forget Password "),
                                SizedBox(
                                  width: 2,
                                ),
                                InkWell(
                                  onTap: () async {
                                    state is TextApearstate ||
                                            state is DarkModestate
                                        ? authWebServices.sendEmail(
                                            AppCubit.get(context).un.text)
                                        : authWebServices
                                            .sendEmail(username.text);
                                  },
                                  child: Text(
                                    "Contact PSU IT ",
                                    style: TextStyle(
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        AppCubit.get(context).darkmode();
                      },
                      icon: Icon(Icons.dark_mode))
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
