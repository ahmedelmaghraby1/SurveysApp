// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:ffi';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/presentation/widgets/sharedprefs.dart';
import 'package:meta/meta.dart';

import 'package:graduation_project/data/models/Surveys.dart';
import 'package:graduation_project/data/repository/avaliablesurveysrepository.dart';

part 'surveys_state.dart';

class SurveysCubit extends Cubit<SurveysState> {
  late String? userName;
  late String? userEName;
  late String? userTypeName;
  late String? userEmail;
  late String? userCollegeName;
  late String? userDeptName;
  late String? userDiveName;
  late String? userLevelName;
  late String? userPhone;
  late String? userSName;

  late int userId;
  late int userTypeID;
  late int userCollegeID;
  late int userLevelID;
  late int serDeptID;
  late int userDivID;
  late int userGender;

  List<String> answer = [];
  // TextEditingController an = TextEditingController();
  List<TextEditingController> tec = [];

  List<Map<String, dynamic>> survey_answers = [];
  Map<String, dynamic> student_survey_answers = {};
  String s_name = "";
  late int s_count;
  late int q_count;
  late List<Map<String, dynamic>> surveys;
  late List<Map<String, dynamic>> survey;
  late SaveSurvey saveSurvey;
  // String answer = "";
  int tcindex = -1;
  Map q_answer = {};

  Future statrfromhome() async {
    emit(StartingFromHome());
  }

  Future viewprofile() async {
    emit(ViewProfile());
  }

  // Future getfromshared() async {
  //   SharedPreferances sharedPreferances = SharedPreferances();

  //   userName = await sharedPreferances.getstring("UserName");
  //   userEName = await sharedPreferances.getstring("UserEName");
  //   userTypeName = await sharedPreferances.getstring("UserTypeName");
  //   userEmail = await sharedPreferances.getstring("UserEmail");
  //   userCollegeName = await sharedPreferances.getstring("UserCollegeName");
  //   userDeptName = await sharedPreferances.getstring("UserDeptName");
  //   userDiveName = await sharedPreferances.getstring("UserDivName");
  //   userLevelName = await sharedPreferances.getstring("UserLevelName");
  //   userPhone = await sharedPreferances.getstring("UserPhoneNumber");
  //   userSName = await sharedPreferances.getstring("UserSTypeName");

  //   userId = await sharedPreferances.getint("UserID") ?? 1;
  //   userTypeID = await sharedPreferances.getint("UserTypeID") ?? 1;
  //   userCollegeID = await sharedPreferances.getint("UserCollegeID") ?? 1;
  //   userLevelID = await sharedPreferances.getint("UserLevelID") ?? 1;
  //   serDeptID = await sharedPreferances.getint("UserDeptID") ?? 1;
  //   userDivID = await sharedPreferances.getint("UserDivID") ?? 1;
  //   userGender = await sharedPreferances.getint("UserGender") ?? 1;
  // }

  String getValueByQID(int qid) {
    for (int i = 0; i < survey_answers.length; i++) {
      if (survey_answers[i]["QID"] == qid) {
        return survey_answers[i]["QAnswerStr"];
      }
    }
    return "null"; // Return null if the QID is not found
  }

  void addMapToList(int qid, String answerStr) {
    // Check if the QID already exists in the listOfMaps
    bool qidExists = false;
    for (int i = 0; i < survey_answers.length; i++) {
      if (survey_answers[i]["QID"] == qid) {
        survey_answers[i]["QAnswerStr"] = answerStr;
        qidExists = true;
        break;
      }
    }
    if (!qidExists) {
      Map<String, dynamic> newMap = {"QID": qid, "QAnswerStr": answerStr};
      survey_answers.add(newMap);
    }
  }

  void emitanswer(Map value) {
    addMapToList(value['"QID"'], value['"QAnswerStr"']);
    // tec[tcindex].text = answer[tcindex];
    emit(SurveyQuestionResponse(survey_answers));
  }

  // void emitsingleanswer(String value) {
  //   answer = value;

  //   emit(SurveySingleQuestionResponse(answer));
  // }

  final AvaliableSurveysRepository avaliableSurveysRepository;
  SurveysCubit(
    this.avaliableSurveysRepository,
  ) : super(SurveysInitial());
  static SurveysCubit get(context) => BlocProvider.of(context);

  Future avalialesurveys(userID, int userTypeId, int collegeId, int levelId,
      int depId, int divId, int gender, int pageNum, int pageSize) async {
    emit((SurveysLoading()));
    await avaliableSurveysRepository
        .avalialesurveys(userID, userTypeId, collegeId, levelId, depId, divId,
            gender, pageNum, pageSize)
        .then((value) {
      // if (value == Surveys()) {
      //   emit(SurveyLoaded(value.dataCount ?? 0,
      //       jsonDecode(value.data ?? "").cast<Map<String, dynamic>>()));
      // } else {
      emit(SurveysLoaded(value.dataCount!,
          jsonDecode(value.data!).cast<Map<String, dynamic>>()));

      s_count = value.dataCount!;
      String d = value.data!;
      surveys = jsonDecode(d).cast<Map<String, dynamic>>();
      // }
    });
    return {s_count, surveys};
  }

  Future surveydetails(int surveyId) async {
    emit((SurveyLoading()));
    await avaliableSurveysRepository.surveydetails(surveyId).then((value) {
      q_count = value.dataCount!;
      String d = value.data!;
      survey = jsonDecode(d).cast<Map<String, dynamic>>();

      print(value.data);
      emit(SurveyLoaded(value.dataCount!,
          jsonDecode(value.data!).cast<Map<String, dynamic>>()));
    });

    return {s_count, surveys};
  }

  Future<SaveSurvey> postsurvey(Map<String, dynamic> surveyanswer) async {
    emit((SurveyLoading()));
    await avaliableSurveysRepository
        .postsurvey(jsonEncode(surveyanswer))
        .then((value) {
      if (value == false) {
        saveSurvey = SaveSurvey();
      } else {
        saveSurvey = value;
        emit(SubmitStudentSurveyAnswer());
      }
    });

    return saveSurvey;
  }
}
