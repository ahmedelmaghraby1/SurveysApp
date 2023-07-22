// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/cubit/surveys_cubit.dart';
import 'package:graduation_project/constants/colors.dart';
import 'package:graduation_project/constants/strings.dart';
import 'package:graduation_project/presentation/widgets/sharedprefs.dart';

class Survey extends StatelessWidget {
  final Map<String, dynamic> surveys;
  const Survey({
    Key? key,
    required this.surveys,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SharedPreferances sharedPreferances = SharedPreferances();
    return BlocBuilder<SurveysCubit, SurveysState>(
      builder: (context, state) {
        String s_name = surveys['Name'];
        ;

        return Container(
          margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: mycolors.mywhite, borderRadius: BorderRadius.circular(8)),
          child: GestureDetector(
            onTap: () {
              sharedPreferances.setint("SurveyMasterID", surveys['id']);
              SurveysCubit.get(context).s_name = surveys['Name'];
              SurveysCubit.get(context)
                  .surveydetails(surveys['id'])
                  .then((value) => Navigator.pushNamed(context, survey_screen));
            },
            child: GridTile(
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
                child: Container(
                    padding: EdgeInsets.only(bottom: 20),
                    margin:
                        EdgeInsets.only(bottom: (s_name.length <= 8 ? 30 : 70)),
                    child: Image.asset(
                      "assets/images/survey-icon-19203.png",
                      height: 100,
                      width: 70,
                    )),
              ),
              footer: ClipRect(
                child: Container(
                  width: double.infinity,
                  color: Colors.transparent,
                  alignment: Alignment.bottomCenter,
                  child: Text(
                    "${surveys['Name']}",
                    style: TextStyle(
                        fontSize: 25,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
