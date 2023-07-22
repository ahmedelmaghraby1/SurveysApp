// ignore_for_file: public_member_api_docs, sort_constructors_firstimport 'dart:math';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/cubit/app_cubit.dart';
import 'package:graduation_project/business_logic/cubit/surveys_cubit.dart';

import 'package:graduation_project/constants/strings.dart';
import 'package:graduation_project/data/models/User.dart' as u;
import 'package:graduation_project/data/repository/userinforepository.dart';
import 'package:graduation_project/data/web_services/surveysavaliablewebservices.dart';
import 'package:graduation_project/data/web_services/userinfowebservices.dart';
import 'package:graduation_project/presentation/screens/surveysscreen.dart';
import 'package:graduation_project/presentation/widgets/sharedprefs.dart';

// import '../../business_logic/cubit/user_cubit.dart';
import '../../data/models/User.dart';
import '../widgets/surveyitem.dart';

class HomePage extends StatelessWidget {
  late int s_count;
  late List<Map<String, dynamic>>? surveys;
  late int q_count;
  late List<Map<String, dynamic>> survey;
  late User user;
  final SharedPreferances sharedPreferances = SharedPreferances();

  Widget waitingscreen() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget no_surveys() {
    return Center(
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(top: 120, bottom: 10),
            child: Text(
              "لا توجد استبيانات",
              style: TextStyle(fontSize: 30),
            ),
          ),
          Container(
            child: Image.asset(
              "assets/images/donee.png",
              height: 250,
              width: 250,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildscreen() {
    return BlocConsumer<SurveysCubit, SurveysState>(
      listener: (context, state) {
        if (state is SubmitStudentSurveyAnswer) {
          SurveysCubit.get(context).avalialesurveys(
              AppCubit.get(context).user.data!.userID!,
              AppCubit.get(context).user.data!.userTypeID!,
              AppCubit.get(context).user.data!.collegeID!,
              AppCubit.get(context).user.data!.levelID!,
              AppCubit.get(context).user.data!.depID!,
              AppCubit.get(context).user.data!.divID!,
              AppCubit.get(context).user.data!.gender!,
              0,
              0);
        }
      },
      builder: (context, state) {
        return BlocBuilder<SurveysCubit, SurveysState>(
          builder: (context, state) {
            s_count = SurveysCubit.get(context).s_count;
            surveys = SurveysCubit.get(context).surveys;
            return s_count == 0 ? no_surveys() : onloadedscreen();
          },
        );
      },
    );
  }

  Widget onloadedscreen() {
    return BlocBuilder<SurveysCubit, SurveysState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            // backgroundColor: Theme.of(context).colorScheme.background,
            body: GridView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: s_count,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 2.4 / 3,
                  mainAxisSpacing: 1,
                  crossAxisSpacing: 1,
                ),
                padding: EdgeInsets.zero,
                itemBuilder: ((context, index) {
                  return GestureDetector(
                    child: Survey(
                      surveys: surveys![index],
                    ),
                  );
                })),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        if (state is UserInfoLoaded) {
          WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
            AwesomeDialog(
                context: context,
                dialogType: DialogType.success,
                title: "Sucsses",
                autoHide: Duration(seconds: 2))
              ..show();
          });
        }
      },
      builder: (context, state) {
        user = AppCubit.get(context).user;
        return Scaffold(
            appBar: AppBar(
              backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
              title: Text("Surveys"),
              centerTitle: true,
            ),
            drawer: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: GestureDetector(
                  onTap: () {
                    AppCubit.get(context).refresh();
                  },
                  child: Drawer(
                    child: ListView(children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, profile_screen);
                        },
                        child: UserAccountsDrawerHeader(
                          arrowColor: Colors.transparent,
                          onDetailsPressed: () {},
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.tertiary,
                          ),
                          accountName: Text(
                            "${user.data!.userEName![0].toUpperCase() + user.data!.userEName!.substring(1)}",
                          ),
                          accountEmail: Text("${user.data!.email}"),
                          currentAccountPicture: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: 40,
                            child: Text(
                              "${user.data!.userEName.toString().substring(0, 2).toUpperCase()}",
                              style: TextStyle(
                                color: Color.fromARGB(255, 6, 77, 135),
                              ),
                            ),
                          ),
                        ),
                      ),
                      ListTile(
                        // onTap: () {},
                        trailing: badges.Badge(
                            child: Icon(Icons.notifications_active),
                            badgeContent:
                                Text("${SurveysCubit.get(context).s_count}")),
                        leading: IconButton(
                          icon: Icon(Icons.notes),
                          onPressed: () {},
                        ),
                        title: Text(
                          "Surveys",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ListTile(
                          onTap: () {
                            AppCubit.get(context).darkmode();
                          },
                          leading: Icon(
                            Icons.dark_mode,
                            color: const Color.fromARGB(255, 164, 148, 5),
                          ),
                          trailing: Icon(Icons.swipe_right),
                          title: Text(
                            "Dark Mode",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        child: ListTile(
                          onTap: () {
                            AppCubit.get(context).un.text = '';
                            AppCubit.get(context).pw.text = '';
                            AppCubit.get(context).username = '';
                            AppCubit.get(context).password = '';
                            // surveysCubit.resetstate();
                            Navigator.pushReplacementNamed(
                                context, login_screen);
                          },
                          trailing: Icon(Icons.logout),
                          leading: Icon(Icons.circle),
                          title: Text(
                            "Logout",
                            style: TextStyle(fontSize: 20),
                          ),
                        ),
                      )
                    ]),
                  ),
                )),
            backgroundColor: Theme.of(context).colorScheme.background,
            body: buildscreen());
      },
    );
  }
}
