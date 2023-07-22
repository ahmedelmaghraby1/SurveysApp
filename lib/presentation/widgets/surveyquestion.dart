// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/business_logic/cubit/app_cubit.dart';
import 'package:graduation_project/business_logic/cubit/surveys_cubit.dart';
import 'package:graduation_project/constants/strings.dart';
import 'package:graduation_project/data/models/Surveys.dart';
import 'package:graduation_project/presentation/widgets/sharedprefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurveyQuestion extends StatelessWidget {
  final List<Map<String, dynamic>> survey;
  const SurveyQuestion({
    Key? key,
    required this.survey,
  }) : super(key: key);

  Widget surveyquestion(int q_type, String q_title, String a_options, int QID,
      int index, BuildContext context) {
    if (q_type == 1) {
      return multiplechoices(q_title, a_options, QID, index, context);
    } else {
      return answerbreifly(q_title, QID, context, index);
    }
  }

  Widget multiplechoices(
      q_title, a_opttions, QID, index, BuildContext context) {
    String? answer;
    List answers = a_opttions.split(';').toList();
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(width: 2, color: Colors.black),
          color: Theme.of(context).colorScheme.onBackground),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "${index + 1} . ${q_title} ",
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textDirection: TextDirection.rtl,
            ),
          ),
          Container(
            height: 56.0 * answers.length,
            child: ListView.builder(
              itemCount: answers.length,
              itemBuilder: (BuildContext context, int index) {
                return Directionality(
                  textDirection: TextDirection.rtl,
                  child: RadioListTile(
                    activeColor: Colors.blue,
                    value: answers[index],
                    groupValue: SurveysCubit.get(context).getValueByQID(QID),
                    onChanged: (value) {
                      Map q_aswers = {"\"QID\"": QID, "\"QAnswerStr\"": value};

                      SurveysCubit.get(context).emitanswer(q_aswers);
                      print(
                        SurveysCubit.get(context).survey_answers,
                      );
                    },
                    onFocusChange: (value) {},
                    title: Text(
                      answers[index],
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget answerbreifly(q_title, QID, BuildContext context, index) {
    SurveysCubit.get(context).tcindex += 1;
    String answer = "";
    TextEditingController tc = new TextEditingController();
    SurveysCubit.get(context).tec.add(tc);
    SurveysCubit.get(context).answer.add(answer);
    return BlocBuilder<SurveysCubit, SurveysState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(width: 2, color: Colors.black),
              color: Colors.white),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                  "${index + 1} . ${q_title} ",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textDirection: TextDirection.rtl,
                ),
              ),
              TextFormField(
                textDirection: TextDirection.rtl,
                minLines: 1,
                maxLength: 500,
                maxLines: 10,
                keyboardType: TextInputType.name,
                textInputAction: TextInputAction.done,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Leave your opinion';
                  }
                },

                // controller: SurveysCubit.get(context)
                //     .tec[SurveysCubit.get(context).tcindex],
                controller: state is SurveyQuestionResponse
                    ? SurveysCubit.get(context)
                        .tec[SurveysCubit.get(context).tcindex]
                    : tc,
                decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(vertical: 50),
                    focusColor: Colors.white,
                    errorStyle:
                        const TextStyle(color: Colors.blue, fontSize: 15),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 6, 77, 135),
                          width: 2,
                        ),
                        gapPadding: 20),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                        borderSide: const BorderSide(
                          color: Color.fromARGB(255, 6, 77, 135),
                          width: 2,
                        ),
                        gapPadding: 20)),
                onFieldSubmitted: (value) {
                  SurveysCubit.get(context)
                      .answer[SurveysCubit.get(context).tcindex] = value;
                  SurveysCubit.get(context)
                      .tec[SurveysCubit.get(context).tcindex]
                      .text = value;
                  Map q_aswers = {
                    "\"QID\"": QID,
                    "\"QAnswerStr\"": SurveysCubit.get(context)
                        .tec[SurveysCubit.get(context).tcindex]
                        .text
                  };
                  SurveysCubit.get(context).emitanswer(q_aswers);
                  print(
                    SurveysCubit.get(context).survey_answers,
                  );
                },
                onTapOutside: (event) {
                  // state is SurveyQuestionResponse?
                  SurveysCubit.get(context)
                          .tec[SurveysCubit.get(context).tcindex]
                          .text =
                      SurveysCubit.get(context)
                          .answer[SurveysCubit.get(context).tcindex];

                  Map q_aswers = {
                    "\"QID\"": QID,
                    "\"QAnswerStr\"": SurveysCubit.get(context)
                        .tec[SurveysCubit.get(context).tcindex]
                        .text
                  };

                  SurveysCubit.get(context).emitanswer(q_aswers);
                  print(
                    SurveysCubit.get(context).survey_answers,
                  );
                },
                // onEditingComplete: () {
                //   Map q_aswers = {
                //     "\"QID\"": QID,
                //     "\"QAnswerStr\"": SurveysCubit.get(context)
                //         .tec[SurveysCubit.get(context).tcindex]
                //         .text
                //   };
                //   SurveysCubit.get(context).emitanswer(q_aswers);
                //   print(
                //     SurveysCubit.get(context).survey_answers,
                //   );
                // },
                // onChanged: (value) {
                //   SurveysCubit.get(context)
                //       .answer[SurveysCubit.get(context).tcindex] = value;
                //   SurveysCubit.get(context)
                //       .tec[SurveysCubit.get(context).tcindex]
                //       .text = value;
                //   Map q_aswers = {
                //     "\"QID\"": QID,
                //     "\"QAnswerStr\"": SurveysCubit.get(context)
                //         .tec[SurveysCubit.get(context).tcindex]
                //         .text
                //   };
                //   SurveysCubit.get(context).emitanswer(q_aswers);
                //   print(
                //     SurveysCubit.get(context).survey_answers,
                //   );
                // },
                onChanged: (val) {
                  SurveysCubit.get(context)
                      .answer[SurveysCubit.get(context).tcindex] = val;
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double hieght = MediaQuery.of(context).size.height;

    return Scaffold(
      body: BlocBuilder<SurveysCubit, SurveysState>(
        builder: (context, state) {
          return SafeArea(
            child: Container(
              color: Theme.of(context).colorScheme.primary,
              child: Column(
                children: [
                  Container(
                    // width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new),
                      onPressed: () {
                        SurveysCubit.get(context).survey_answers.clear();
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  Center(
                    child: Container(
                        // margin: EdgeInsets.only(left: 110),
                        child: Text(
                      "${SurveysCubit.get(context).s_name}",
                      style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                  Expanded(
                    child: BlocConsumer<SurveysCubit, SurveysState>(
                      listener: (context, state) {
                        // TODO: implement listener
                      },
                      builder: (context, state) {
                        return ListView.separated(
                          separatorBuilder: (context, index) {
                            return index == survey.length
                                ? Divider(
                                    height: 10,
                                    thickness: 5,
                                  )
                                : Container();
                          },
                          itemCount: survey.length + 1,
                          itemBuilder: (BuildContext context, int index) {
                            return index < survey.length
                                ? Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                          border: Border.all(
                                              width: 2, color: Colors.black)),
                                      child: surveyquestion(
                                          survey[index]['QuesTypeID'],
                                          survey[index]['Title'],
                                          survey[index]['Contnt'],
                                          survey[index]['id'],
                                          index,
                                          context),
                                    ),
                                  )
                                : TextButton(
                                    onPressed: () async {
                                      SharedPreferances sharedPreferances =
                                          SharedPreferances();
                                      int s_answers_count =
                                          SurveysCubit.get(context)
                                              .survey_answers
                                              .length;
                                      int? userid = await sharedPreferances
                                          .getint("UserID");
                                      int? usertypeid = await sharedPreferances
                                          .getint("UserTypeID");
                                      int? surveymasterid =
                                          await sharedPreferances
                                              .getint("SurveyMasterID");

                                      if (s_answers_count == survey.length) {
                                        Map<String, dynamic> survey = {
                                          "UserTypeID": usertypeid,
                                          "UserID": userid,
                                          "MasterID": surveymasterid,
                                          "QAnswers": SurveysCubit.get(context)
                                              .survey_answers
                                        };
                                        // print(survey);
                                        SurveysCubit.get(context)
                                            .postsurvey(survey);
                                        SurveysCubit.get(context)
                                            .survey_answers = [];
                                        Navigator.pushReplacementNamed(
                                            context, home_screen);
                                        if (state
                                            is SubmitStudentSurveyAnswer) {
                                          AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.success,
                                              title: "Sucsses",
                                              autoHide: Duration(seconds: 2))
                                            ..show();
                                        }
                                      } else if (s_answers_count !=
                                          survey.length) {
                                        AwesomeDialog(
                                          context: context,
                                          dialogType: DialogType.error,
                                          title:
                                              "You didn't answer all the questions ",
                                          // btnCancelOnPress: () {},
                                          // btnOkOnPress: () {})
                                        )..show();
                                      }
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color:
                                              Color.fromARGB(255, 6, 77, 135),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      padding: EdgeInsets.only(
                                          right: 20,
                                          left: 20,
                                          bottom: 10,
                                          top: 10),
                                      child: Text(
                                        "Submit",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    ));
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
