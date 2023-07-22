// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_project/approuter.dart';
import 'package:graduation_project/constants/strings.dart';
import 'package:graduation_project/constants/themes.dart';
import 'package:graduation_project/data/models/Surveys.dart';
import 'package:graduation_project/data/repository/avaliablesurveysrepository.dart';
import 'package:graduation_project/data/repository/userinforepository.dart';
import 'package:graduation_project/data/web_services/surveysavaliablewebservices.dart';
import 'package:graduation_project/data/web_services/userinfowebservices.dart';
import 'package:graduation_project/presentation/screens/home.dart';
import 'package:graduation_project/presentation/screens/homepage.dart';
import 'package:graduation_project/presentation/screens/login_Screen.dart';
import 'package:graduation_project/presentation/screens/profile.dart';
import 'package:graduation_project/presentation/screens/surveysscreen.dart';
import 'package:graduation_project/presentation/widgets/sharedprefs.dart';

import 'business_logic/cubit/app_cubit.dart';
import 'business_logic/cubit/surveys_cubit.dart';

void main() async {
  // AvaliableSurveys avaliableSurveys = AvaliableSurveys();
  // avaliableSurveys.avalialesurveys(4, 1, 1, 4, 4, 3, 1, 0, 0);
  // print(Surveys().dataCount);
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferances sharedPreferances = SharedPreferances();

  int userid = await sharedPreferances.getint("UserID") ?? 1;
  bool token = await sharedPreferances.getbool("IsLoggedIn") ?? false;
  bool? dark_mode = await sharedPreferances.getbool("dark_mode");
  // print(userid);
  runApp(StudentSurveys(
    dark_mode: dark_mode,
  ));
}

class StudentSurveys extends StatelessWidget {
  final bool? dark_mode;

  const StudentSurveys({
    Key? key,
    required this.dark_mode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => AppCubit(AuthRepository(AuthWebServices()))
                ..changemode(dark_mode)),
          BlocProvider(
              create: (context) =>
                  SurveysCubit(AvaliableSurveysRepository(AvaliableSurveys())))
        ],
        child: BlocBuilder<AppCubit, AppState>(
          builder: (context, state) {
            return MaterialApp(
                routes: {
                  login_screen: (context) => LoginScreen(
                      key,
                      AuthRepository(AuthWebServices()),
                      AvaliableSurveysRepository(AvaliableSurveys())),
                  home_screen: (context) => HomePage(),
                  profile_screen: (context) => ProfilePage(),
                  survey_screen: (context) => SurveyScreen(),
                },
                debugShowCheckedModeBanner: false,
                theme: AppCubit.get(context).dark_mode == false
                    ? lightTheme
                    : darkTheme);
          },
        ));
  }
}
