// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:graduation_project/data/models/Surveys.dart';
import 'package:graduation_project/data/web_services/surveysavaliablewebservices.dart';

class AvaliableSurveysRepository {
  final AvaliableSurveys avaliableSurveys;
  AvaliableSurveysRepository(this.avaliableSurveys);
  Future<Surveys> avalialesurveys(
      int userID,
      int userTypeId,
      int collegeId,
      int levelId,
      int depId,
      int divId,
      int gender,
      int pageNum,
      int pageSize) async {
    final d = await avaliableSurveys.avalialesurveys(userID, userTypeId,
        collegeId, levelId, depId, divId, gender, pageNum, pageSize);
    if (d == 0) {
      return Surveys(dataCount: 0, data: "[]");
    } else {
      Surveys data = Surveys.fromJson(d);
      return data;
    }
  }

  Future<Survey> surveydetails(int surveyId) async {
    final d = await avaliableSurveys.surveydetails(surveyId);
    Survey data = Survey.fromJson(d);
    return data;
  }

  Future<dynamic> postsurvey(String surveyanswer) async {
    final d = await avaliableSurveys.postsurvey(surveyanswer);
    if (d != false) {
      SaveSurvey data = SaveSurvey.fromJson(d);
      return data;
    } else {
      return false;
    }
  }
}
